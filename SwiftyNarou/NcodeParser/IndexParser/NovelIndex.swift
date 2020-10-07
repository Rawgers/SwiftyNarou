//
//  NovelIndex.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

struct NovelIndex: Codable, Equatable {
    let seriesTitle: String
    let seriesNcode: String
    let novelTitle: String
    let author: String
    let synopsis: String
    var chapters: [Chapter]
    
    mutating func addChapter(_ chapter: Chapter) {
        chapters.append(chapter)
    }
    
    static func == (lhs: NovelIndex, rhs: NovelIndex) -> Bool {
        return lhs.seriesTitle == rhs.seriesTitle
            && lhs.seriesNcode == rhs.seriesNcode
            && lhs.novelTitle == rhs.novelTitle
            && lhs.author == rhs.author
            && lhs.synopsis == rhs.synopsis
            && lhs.chapters == rhs.chapters
    }
}

struct Chapter: Codable, Equatable {
    let title: String
    var sections: [Section]
    
    mutating func addSection(_ section: Section) {
        sections.append(section)
    }
    
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.title == rhs.title && lhs.sections == rhs.sections
    }
}

struct Section: Codable, Equatable {
    let title: String
    let ncode: String
    let uploadTime: String
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.title == rhs.title
            && lhs.ncode == rhs.ncode
            && lhs.uploadTime == rhs.uploadTime
    }
}
