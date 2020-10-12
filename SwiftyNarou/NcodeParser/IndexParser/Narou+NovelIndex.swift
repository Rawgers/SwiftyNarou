//
//  Narou+FetchNovel.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

import SwiftSoup

extension Narou {
    public func fetchNovelIndex(ncode: String, completionHandler: @escaping (NovelIndex?, Error?) -> Void) {
        let urlString = Constants.SYOSETU_NCODE_URL + ncode
        fetchNovelIndex(urlString: urlString, completionHandler: completionHandler)
    }
    
    public func fetchNovelIndex(urlString: String, completionHandler: @escaping (NovelIndex?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, NarouError.MalformedUrl(malformedUrl: urlString))
            return
        }
        fetchNovelIndex(url: url, completionHandler: completionHandler)
    }
    
    public func fetchNovelIndex(url: URL, completionHandler: @escaping (NovelIndex?, Error?) -> Void) {
        let ncode = url.pathComponents[1]
        if ncode.first != "n" {
            completionHandler(nil, NarouError.IncorrectNcode(badNcode: ncode))
            return
        }
        
        fetchNcodeHtml(url: url) { content, error in
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            let novelIndex = self.filterNovelIndexHtml(html: content!)
            DispatchQueue.main.async {
                completionHandler(novelIndex, nil)
            }
        }
    }

    func filterNovelIndexHtml(html: String) -> NovelIndex? {
        do {
            let doc = try SwiftSoup.parse(html)
            let containerSelection = try doc.select("#novel_color").first()!
            
            var seriesTitle = ""
            var seriesNcode = ""
            var novelTitle = ""
            var writer = ""
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
                    writer = parseWriter(selection: element)
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
                writer: writer,
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
    
    func parseWriter(selection: Element) -> String {
        let writerLabel = (try? selection.text()) ?? ""
        guard let colonIndex = writerLabel.firstIndex(of: "：") else {
            return writerLabel
        }
        let writerIndex = writerLabel.index(after: colonIndex)
        return String(writerLabel[writerIndex...])
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
