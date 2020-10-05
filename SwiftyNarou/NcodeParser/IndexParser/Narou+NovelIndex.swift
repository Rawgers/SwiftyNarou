//
//  Narou+FetchNovel.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

import SwiftSoup

extension Narou {
    func fetchNovelIndex(ncode: String, callback: @escaping (Data?, Error?) -> Void) {
        let urlString = Constants.SYOSETU_NCODE_URL + ncode
        fetchNovelIndex(urlString: urlString, callback: callback)
    }
    
    func fetchNovelIndex(urlString: String, callback: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            callback(nil, NcodeParserError.MalformedUrl(malformedUrl: urlString))
            return
        }
        fetchNovelIndex(url: url, callback: callback)
    }
    
    func fetchNovelIndex(url: URL, callback: @escaping (Data?, Error?) -> Void) {
        let ncode = url.pathComponents[1]
        if ncode.first != "n" {
            callback(nil, NcodeParserError.IncorrectNcode(badNcode: ncode))
            return
        }
        
        task?.cancel()
        
        task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    callback(
                        nil,
                        NcodeParserError.ClientError(message: error.localizedDescription)
                    )
                    return
                }
            }
            
            let httpResponse = response as! HTTPURLResponse
            if !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    callback(
                        nil,
                        NcodeParserError.ServerError(errorCode: httpResponse.statusCode)
                    )
                    return
                }
            }
            
            if let mimeType = httpResponse.mimeType,
                mimeType != "text/html" {
                DispatchQueue.main.async {
                    callback(
                        nil,
                        NcodeParserError.MimetypeError(incorrectMimetype: mimeType)
                    )
                }
                return
            }
            
            guard let contentsData = data,
                let contents = String(data: contentsData, encoding: .utf8) else {
                DispatchQueue.main.async {
                    callback(
                        nil,
                        NcodeParserError.ContentsError(badData: data?.debugDescription ?? "")
                    )
                }
                return
            }
            
            let novelIndex = self.filterNovelIndexHtml(html: contents)
            DispatchQueue.main.async {
                if novelIndex != nil {
                    callback(try! JSONEncoder().encode(novelIndex), nil)
                } else {
                    callback(Data(), nil)
                }
            }
        }
        
        task?.resume()
    }

    func filterNovelIndexHtml(html: String) -> NovelIndex? {
        let metadataSelection: Element
        let indexSelection: Element
        do {
            let doc = try SwiftSoup.parse(html)
            metadataSelection = try doc.select("#novel_color").first()!
            indexSelection = try doc.select(".index_box").first()!
            
            guard let novelIndex = parseNovelIndexHeader(header: metadataSelection) else {
                return nil
            }
            parseNovelIndexBody(body: indexSelection, novelIndex)
            return novelIndex
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return nil
    }
    
    /**
     Header includes the `seriesTitle`, `seriesNcode`, `novelTitle`, `writer`, and `synopsis` of a `NovelIndex`.
     */
    func parseNovelIndexHeader(header: Element) -> NovelIndex? {
        var seriesTitle = ""
        var seriesNcode = ""
        var novelTitle = ""
        var author = ""
        var synopsis = ""
        
        do {
            let seriesTitleSelection = try header.select(".series_title").first()?.select("a").first()
            seriesTitle = try seriesTitleSelection?.text() ?? ""
            seriesNcode = try seriesTitleSelection?.attr("href") ?? ""
            novelTitle = try header.select(".novel_title").first()?.text() ?? ""
            
            if let authorLabel = try header.select(".novel_writername").first()?.text(),
                let colonIndex = authorLabel.firstIndex(of: "：") {
                let authorIndex = authorLabel.index(after: colonIndex)
                author = String(authorLabel[authorIndex...])
            }
            
            let synopsisSelection = try header.select("#novel_ex").first()
            try synopsisSelection?.select("br").after("\\n")
            let rawSynopsis = try synopsisSelection?.text()
            if rawSynopsis != nil {
                synopsis = rawSynopsis!
                    .replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "\u{3000}", with: "")
            }
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return NovelIndex(
            seriesTitle: seriesTitle,
            seriesNcode: seriesNcode,
            novelTitle: novelTitle,
            author: author,
            synopsis: synopsis,
            chapters: []
        )
    }
    
    /**
     Parses the `index_box` div into `Chapters` and `Sections`.
     */
    func parseNovelIndexBody(body: Element, _ novelIndex: NovelIndex) {
        
    }
    
}
