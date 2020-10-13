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
    let ncode: [String]?
    let userId: [String]?
    
    /* MARK: Query for text */
    let word: String?
    let notWord: String?
    let inText: [QueryTextTarget]?
    
    /* MARK: Query by genre */
    let bigGenre: [BigGenre]?
    let notBigGenre: [BigGenre]?
    let genre: [Genre]?
    let notGenre: [Genre]?
    
    /* MARK: Query by theme */
    let isR15: Bool?
    let isBoysLove: Bool?
    let isGirlsLove: Bool?
    let isZankoku: Bool?
    let isTensei: Bool?
    let isTenni: Bool?
    let isIsekai: Bool? // both isTensei and isTenni
    
    /* MARK: Query by content metadata */
    
    // length
    let charCount: (min: Int?, max: Int?)?
    
    // kaiwaritu
    let dialogueRatio: (min: Int?, max: Int?)?
    
    // sasie
    let illustrations: (min: Int?, max: Int?)?
    
    // time
    let readingTime: (min: Int?, max: Int?)?
    
    // type
    let novelType: QueryNovelType?
    
    // buntai
    let compositionStyle: [QueryCompositionStyle]?
    
    /* MARK: Query by status */
    
    // stop
    let shouldIncludeHiatus: Bool?
    
    // last update
    let recentUpdate: String?
    let recentUpdateUnix: (from: Int?, to: Int?)?

    let isPickup: Bool?
}
