//
//  NovelIndex.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

struct NovelIndex: Codable {
    let seriesTitle: String
    let seriesNcode: String
    let novelTitle: String
    let author: String
    let synopsis: String
    var chapters: [Chapter]
    
    mutating func addChapter(_ chapter: Chapter) {
        chapters.append(chapter)
    }
}

struct Chapter: Codable {
    let title: String
    var sections: [Section]
    
    mutating func addSection(_ section: Section) {
        sections.append(section)
    }
}

struct Section: Codable {
    let title: String
    let ncode: String
    let uploadTime: String
}
