//
//  NarouRequest.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/11/20.
//

public enum QueryTextTarget: String {
    case title = "title"
    case synopsis = "ex"
    case tags = "keyword"
    case author = "wname"
}

public enum QueryNovelType: String {
    case shortStory = "t"
    case ongoingSeries = "r"
    case completedSeries = "er"
    case allSeries = "re"
    case completed = "ter" // shortStory + completedSeries
}

public enum QueryCompositionStyle: Int {
    case noIndentationAndManyConsecutiveLineBreaks = 1
    case noIndentationAndAverageLineBreaks = 2
    case IndentationAndManyConsecutiveLineBreaks = 4
    case IndentationAndAverageLineBreaks = 6
}

public enum QueryRecent: String {
    case thisWeek = "thisweek"
    case lastWeek = "lastweek"
    case sevenDay = "sevenday"
    case thisMonth = "thismonth"
    case lastMonth = "lastmonth"
}

public struct NarouRequest {
    /* MARK: Query by ID */
    public let ncode: [String]?
    public let userId: [String]?
    
    /* MARK: Query for text */
    public let word: String?
    public let notWord: String?
    public let inText: [QueryTextTarget]?
    
    /* MARK: Query by genre */
    public let bigGenre: [BigGenre]?
    public let notBigGenre: [BigGenre]?
    public let genre: [Genre]?
    public let notGenre: [Genre]?
    
    /* MARK: Query by theme */
    public let isR15: Bool?
    public let isBoysLove: Bool?
    public let isGirlsLove: Bool?
    public let isZankoku: Bool?
    public let isTensei: Bool?
    public let isTenni: Bool?
    public let isIsekai: Bool? // both isTensei and isTenni
    
    /* MARK: Query by content metadata */
    
    // length
    public let charCount: (min: Int?, max: Int?)?
    
    // kaiwaritu
    public let dialogueRatio: (min: Int?, max: Int?)?
    
    // sasie
    public let illustrations: (min: Int?, max: Int?)?
    
    // time
    public let readingTime: (min: Int?, max: Int?)?
    
    // type
    public let novelType: QueryNovelType?
    
    // buntai
    public let compositionStyle: [QueryCompositionStyle]?
    
    /* MARK: Query by status */
    
    // stop
    public let shouldIncludeHiatus: Bool?
    
    // last update
    public let recentUpdate: String?
    public let recentUpdateUnix: (from: Int?, to: Int?)?

    public let isPickup: Bool?
}
