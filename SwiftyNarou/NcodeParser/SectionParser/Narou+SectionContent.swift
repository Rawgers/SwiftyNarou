//
//  Narou+FetchNovelSection.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

import SwiftSoup

extension Narou {
    public static func fetchSectionData(
        ncode: String,
        completionHandler: @escaping (SectionData?, Error?) -> Void
    ) {
        let urlString = Constants.SYOSETU_NCODE_URL + ncode
        fetchSectionData(urlString: urlString, completionHandler: completionHandler)
    }
    
    public static func fetchSectionData(
        urlString: String,
        completionHandler: @escaping (SectionData?, Error?) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, NarouError.MalformedUrl(malformedUrl: urlString))
            return
        }
        fetchSectionData(url: url, completionHandler: completionHandler)
    }
    
    public static func fetchSectionData(
        url: URL,
        completionHandler: @escaping (SectionData?, Error?) -> Void
    ) {
        if url.pathComponents.endIndex != 3 {
            completionHandler(
                nil,
                NarouError.InvalidNcode(
                    badNcode: "\(url.pathComponents.joined())"
                )
            )
            return
        }
        
        let ncode = url.pathComponents[1]
        let sectionId = url.pathComponents[2]
        if (ncode.first != "n" && ncode.first != "N") || Int(sectionId) == nil {
            completionHandler(
                nil,
                NarouError.InvalidNcode(
                    badNcode: "\(ncode)/\(sectionId)"
                )
            )
            return
        }
        
        fetchNarou(url: url) { data, error in
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            let sectionData = self.filterSectionDataHtml(
                html: String(
                    data: data!,
                    encoding: .utf8
                )!
            )
            DispatchQueue.main.async {
                completionHandler(sectionData, nil)
            }
        }
    }

    static func filterSectionDataHtml(html: String) -> SectionData? {
        do {
            let doc = try SwiftSoup.parse(html)
            let metadataSelection = (try doc.select(".contents1")).first()!
            let novelColorSelection = (try doc.select("#novel_color")).first()!
            
            var sectionTitle = ""
            var chapterTitle: String?
            var novelTitle = ""
            var writer = ""
            var content = ""
            var format = [NSRange: String]()
            var prevNcode: String?
            var nextNcode: String?
            var progress = ""
            
            (novelTitle, writer, chapterTitle) = parseMetadataSelection(selection: metadataSelection)
            for child in novelColorSelection.children() {
                var label = (try? child.attr("class")) ?? ""
                if (label == "") {
                    label = (try? child.attr("id")) ?? ""
                }
                switch label {
                case "novel_bn":
                    (prevNcode, nextNcode) = parsePrevAndNextButtons(selection: child)
                case "novel_no":
                    progress = try! child.text()
                case "novel_subtitle":
                    sectionTitle = try! child.text()
                case "novel_view":
                    (content, format) = parseSectionBody(selection: child)
                default:
                    if child.tagName() == "p" {
                        chapterTitle = try (
                            try child.select(".novel_subtitle")
                        ).text()
                    }
                }
            }
            
            return SectionData(
                sectionTitle: sectionTitle,
                chapterTitle: chapterTitle,
                novelTitle: novelTitle,
                writer: writer,
                content: content,
                format: format,
                prevNcode: prevNcode,
                nextNcode: nextNcode,
                progress: progress
            )
        } catch {
            return nil
        }
    }
    
    static func parseMetadataSelection(selection: Element) -> (
        novelTitle: String,
        writer: String,
        chapterTitle: String?
    ) {
        var novelTitle = ""
        var writer = ""
        var chapterTitle: String?
        
        for (i, child) in selection.children().enumerated() {
            switch i {
            case 0:
                novelTitle = (try? child.text()) ?? ""
            case 1:
                writer = (try? child.text()) ?? ""
            case 2:
                chapterTitle = (try? child.text()) ?? ""
            default:
                break
            }
        }
        
        return (novelTitle, writer, chapterTitle)
    }
    
    static func parsePrevAndNextButtons(selection: Element) -> (
        prevNcode: String?,
        nextNcode: String?
    ) {
        var prevNcode: String?
        var nextNcode: String?
        
        for child in selection.children() {
            let text = (try? child.text()) ?? ""
            if text.contains("前へ") {
                prevNcode = (try? child.attr("href"))?.trimmingCharacters(in: ["/"])
            } else if text.contains("次へ") {
                nextNcode = (try? child.attr("href"))?.trimmingCharacters(in: ["/"])
            }
        }
        
        return (prevNcode, nextNcode)
    }
    
    static func parseSectionBody(selection: Element) -> (
        content: String,
        format: [NSRange: String]
    ) {
        var content = ""
        var format = [NSRange: String]()
        
        var charCount = 0
        for pElement in selection.children() {
            if pElement.children().isEmpty() {
                let text = (try? pElement.text()) ?? ""
                if text != "" {
                    content += text + "\n"
                    charCount += text.count + 1
                }
                continue
            }
            else {
                for node in pElement.getChildNodes() {
                    if node is TextNode {
                        let text = (node as! TextNode).text().trimmingCharacters(in: [" "])
                        content += text
                        charCount += text.count
                    } else if node is Element {
                        let element = node as! Element
                        switch element.tagName() {
                        case "ruby":
                            let rubyData = parseRuby(selection: element)
                            let baseRangeIndex = getAppendRange(
                                content: &content,
                                charCount: &charCount,
                                base: rubyData.base
                            )
                            format[baseRangeIndex] = rubyData.furigana
                        default:
                            break
                        }
                    }
                }
                // Handles <br> tags and makes sure that each <ruby> ends with a line break.
                if content != "" {
                    content += "\n"
                    charCount += 1
                }
            }
        }
        
        return (
            content.trimmingCharacters(in: .newlines),
            format
        )
    }
    
    /// Deletes <rp> and <rt> elements. Returns a tuple of a base term and its furigana.
    static func parseRuby(selection: Element) -> (base: String, furigana: String) {
        var base = ""
        var furigana = ""
        
        for element in selection.children() {
            switch element.tagName() {
            case "rp":
                try! element.remove()
            case "rt":
                furigana = try! element.text()
                try! element.remove()
            case "rb":
                base = try! element.text()
            default:
                break
            }
        }
        
        return (base, furigana)
    }
    
    private static func getAppendRange(
        content: inout String,
        charCount: inout Int,
        base: String
    ) -> NSRange {
        let lowerBound = charCount
        content += base
        charCount += base.count
        let baseRange = NSMakeRange(
            lowerBound,
            charCount - lowerBound
        )
        return baseRange
    }
}
