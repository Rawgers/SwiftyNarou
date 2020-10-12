//
//  SectionContents.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/8/20.
//

public struct SectionContent {
    public let sectionTitle: String
    public let chapterTitle: String?
    public let novelTitle: String
    public let writer: String
    public let content: String
    public let format: [NSRange: String]
    public let prevNcode: String?
    public let nextNcode: String?
    public let progress: String
}
