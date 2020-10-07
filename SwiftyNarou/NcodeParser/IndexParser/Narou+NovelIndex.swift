//
//  Narou+FetchNovel.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

import SwiftSoup

extension Narou {
    public func fetchNovelIndex(ncode: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let urlString = Constants.SYOSETU_NCODE_URL + ncode
        fetchNovelIndex(urlString: urlString, completionHandler: completionHandler)
    }
    
    public func fetchNovelIndex(urlString: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, NarouError.MalformedUrl(malformedUrl: urlString))
            return
        }
        fetchNovelIndex(url: url, completionHandler: completionHandler)
    }
    
    public func fetchNovelIndex(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let ncode = url.pathComponents[1]
        if ncode.first != "n" {
            completionHandler(nil, NarouError.IncorrectNcode(badNcode: ncode))
            return
        }
        
        fetchNovelIndexData(url: url) { contents, error in
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            let novelIndex = self.filterNovelIndexHtml(html: contents!)
            if novelIndex != nil {
                completionHandler(try! JSONEncoder().encode(novelIndex), nil)
            } else {
                completionHandler(nil, nil)
            }
        }
    }
    
    func fetchNovelIndexData(url: URL, _ completionHandler: @escaping (String?, Error?) -> Void) {
        task?.cancel()
        
        task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(
                    nil,
                    NarouError.ClientError(message: error.localizedDescription)
                )
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            if !(200...299).contains(httpResponse.statusCode) {
                completionHandler(
                    nil,
                    NarouError.ServerError(errorCode: httpResponse.statusCode)
                )
                return
            }
            
            if let mimeType = httpResponse.mimeType,
                mimeType != "text/html" {
                completionHandler(
                    nil,
                    NarouError.MimetypeError(incorrectMimetype: mimeType)
                )
                return
            }
            
            if let contentsData = data,
                let contents = String(data: contentsData, encoding: .utf8) {
                completionHandler(contents, nil)
            } else {
                completionHandler(
                    nil,
                    NarouError.ContentsError(badData: data?.debugDescription ?? "")
                )
            }
        }
        
        task?.resume()
    }

    func filterNovelIndexHtml(html: String) -> NovelIndex? {
        do {
            let doc = try SwiftSoup.parse(html)
            let containerSelection = try doc.select("#novel_color").first()!
            
            var seriesTitle = ""
            var seriesNcode = ""
            var novelTitle = ""
            var author = ""
            var synopsis = ""
            var chapters = [Chapter]()

            for element in containerSelection.children() {
                switch try element.attr("class") {
                case "series_title":
                    let seriesInfo = parseSeriesInfo(selection: element)
                    seriesTitle = seriesInfo.seriesTitle
                    seriesNcode = seriesInfo.ncode
                case "novel_title":
                    novelTitle = parseNovelTitle(selection: element)
                case "novel_writername":
                    author = parseAuthor(selection: element)
                case "index_box":
                    chapters = parseChapters(selection: element)
                default:
                    if try element.attr("id") == "novel_ex" {
                        synopsis = parseSynopsis(selection: element)
                    }
                }
            }
            
            return NovelIndex(
                seriesTitle: seriesTitle,
                seriesNcode: seriesNcode,
                novelTitle: novelTitle,
                author: author,
                synopsis: synopsis,
                chapters: chapters
            )
        } catch {
            return nil
        }
    }
    
    func parseSeriesInfo(selection: Element) -> (seriesTitle: String, ncode: String) {
        let seriesTitle = (try? selection.text()) ?? ""
        let seriesNcode = (try? selection.child(0).attr("href"))?.trimmingCharacters(in: ["/"]) ?? ""
        return (seriesTitle, seriesNcode)
    }
    
    func parseNovelTitle(selection: Element) -> String {
        return (try? selection.text()) ?? ""
    }
    
    func parseAuthor(selection: Element) -> String {
        let authorLabel = (try? selection.text()) ?? ""
        guard let colonIndex = authorLabel.firstIndex(of: "：") else {
            return authorLabel
        }
        let authorIndex = authorLabel.index(after: colonIndex)
        return String(authorLabel[authorIndex...])
    }
    
    func parseSynopsis(selection: Element) -> String {
        do {
            try selection.select("br").after("\\n")
            let rawSynopsis = try selection.text()
            return rawSynopsis
                .replacingOccurrences(of: "\\n", with: "\n")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "\u{3000}", with: "")
        } catch {
            return ""
        }
    }
    
    func parseChapters(selection: Element) -> [Chapter] {
        var chapters = [Chapter]()
        var title = ""
        var sections = [Section]()
        for element in selection.children() {
            if element.hasClass("chapter_title") {
                if !(title == "" && sections == []) {
                    chapters.append(Chapter(
                        title: title,
                        sections: sections
                    ))
                }
                title = (try? element.text()) ?? ""
                sections = [Section]()
            } else if element.hasClass("novel_sublist2") {
                sections.append(parseSection(selection: element))
            }
        }
        chapters.append(Chapter(
            title: title,
            sections: sections
        ))
        return chapters
    }
    
    func parseSection(selection: Element) -> Section {
        var title = ""
        var ncode = ""
        var uploadTime = ""
        var lastUpdate: String? = nil
        
        let sectionLink = selection.child(0).child(0)
        title = (try? sectionLink.text()) ?? ""
        ncode = (try? sectionLink.attr("href"))?
            .trimmingCharacters(in: ["/"]) ?? ""
        
        let publishTime = selection.child(1)
        uploadTime = (try? publishTime.text())?
            .replacingOccurrences(of: " （ 改 ）", with: "") ?? ""
        lastUpdate = (try? publishTime.select("span").first()?.attr("title"))?
            .replacingOccurrences(of: " 改稿", with: "")
        
        return Section(
            title: title,
            ncode: ncode,
            uploadTime: uploadTime,
            lastUpdate: lastUpdate
        )
    }
}
