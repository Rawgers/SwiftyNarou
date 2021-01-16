//
//  SectionData.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/8/20.
//

public struct SectionData {
    public let sectionTitle: String
    public let chapterTitle: String?
    public let novelTitle: String
    public let writer: String
    public let content: String
    public let format: [NSRange: String]
    public let prevNcode: String?
    public let nextNcode: String?
    public let progress: String
    
    public init(
        sectionTitle: String,
        chapterTitle: String?,
        novelTitle: String,
        writer: String,
        content: String,
        format: [NSRange : String],
        prevNcode: String?,
        nextNcode: String?,
        progress: String
    ) {
        self.sectionTitle = sectionTitle
        self.chapterTitle = chapterTitle
        self.novelTitle = novelTitle
        self.writer = writer
        self.content = content
        self.format = format
        self.prevNcode = prevNcode
        self.nextNcode = nextNcode
        self.progress = progress
    }
}
