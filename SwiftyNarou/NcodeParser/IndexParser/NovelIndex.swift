//
//  NovelIndex.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

public struct NovelIndex: Equatable, Hashable {
    public let seriesTitle: String
    public let seriesNcode: String
    public let novelTitle: String
    public let writer: String
    public let synopsis: String
    public var chapters: [Chapter]
    
    mutating func addChapter(_ chapter: Chapter) {
        chapters.append(chapter)
    }
    
    public static func == (lhs: NovelIndex, rhs: NovelIndex) -> Bool {
        return lhs.seriesTitle == rhs.seriesTitle
            && lhs.seriesNcode == rhs.seriesNcode
            && lhs.novelTitle == rhs.novelTitle
            && lhs.writer == rhs.writer
            && lhs.synopsis == rhs.synopsis
            && lhs.chapters == rhs.chapters
    }
}

public struct Chapter: Equatable, Hashable {
    public let title: String
    public var sections: [Section]
    
    mutating func addSection(_ section: Section) {
        sections.append(section)
    }
    
    public static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.title == rhs.title && lhs.sections == rhs.sections
    }
}

public struct Section: Equatable, Hashable {
    public let title: String
    public let ncode: String
    public let uploadTime: String
    public let lastUpdate: String?
    
    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.title == rhs.title
            && lhs.ncode == rhs.ncode
            && lhs.uploadTime == rhs.uploadTime
            && lhs.lastUpdate == rhs.lastUpdate
    }
}
