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

public enum QueryPublicationType: String {
    case shortStory = "t"
    case ongoingSeries = "r"
    case completedSeries = "er"
    case allSeries = "re"
    case completed = "ter" // shortStory + completedSeries
}

public enum QueryCompositionStyle: Int {
    case noIndentationAndManyConsecutiveLineBreaks = 1
    case noIndentationAndAverageLineBreaks = 2
    case indentationAndManyConsecutiveLineBreaks = 4
    case indentationAndAverageLineBreaks = 6
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
    // TODO: investigate false case for isIsekai
    public let isIsekai: Bool? // both isTensei and isTenni
    
    /* MARK: Query by content metadata */
    
    // length
    public let charCount: (min: Int?, max: Int?)?
    
    // kaiwaritu
    public let dialogueRatio: (min: Int?, max: Int?)?
    
    // sasie
    public let illustrationCount: (min: Int?, max: Int?)?
    
    // time
    public let readingTime: (min: Int?, max: Int?)?
    
    // type
    public let publicationType: QueryPublicationType?
    
    // buntai
    public let compositionStyle: [QueryCompositionStyle]?
    
    /* MARK: Query by status */
    
    // stop
    // {1, 2}: 1 excludes hiatus, 2 finds only hiatus
    public let isHiatus: Bool?
    
    // last update
    public let recentUpdate: QueryRecent?
    public let recentUpdateUnix: (from: Int?, to: Int?)?

    // TODO: investigate false case
    public let isPickup: Bool?
    
    /* MARK: Response field selectors */
    public let responseFormat: NarouResponseFormat?
    
    public init(
        ncode: [String]? = nil,
        userId: [String]? = nil,
        word: String? = nil,
        notWord: String? = nil,
        inText: [QueryTextTarget]? = nil,
        bigGenre: [BigGenre]? = nil,
        notBigGenre: [BigGenre]? = nil,
        genre: [Genre]? = nil,
        notGenre: [Genre]? = nil,
        isR15: Bool? = nil,
        isBoysLove: Bool? = nil,
        isGirlsLove: Bool? = nil,
        isZankoku: Bool? = nil,
        isTensei: Bool? = nil,
        isTenni: Bool? = nil,
        isIsekai: Bool? = nil,
        charCount: (min: Int?, max: Int?)? = nil,
        dialogueRatio: (min: Int?, max: Int?)? = nil,
        illustrationCount: (min: Int?, max: Int?)? = nil,
        readingTime: (min: Int?, max: Int?)? = nil,
        publicationType: QueryPublicationType? = nil,
        compositionStyle: [QueryCompositionStyle]? = nil,
        isHiatus: Bool? = nil,
        recentUpdate: QueryRecent? = nil,
        recentUpdateUnix: (from: Int?, to: Int?)? = nil,
        isPickup: Bool? = nil,
        responseFormat: NarouResponseFormat? = nil
    ) {
        self.ncode = ncode
        self.userId = userId
        self.word = word
        self.notWord = notWord
        self.inText = inText
        self.bigGenre = bigGenre
        self.notBigGenre = notBigGenre
        self.genre = genre
        self.notGenre = notGenre
        self.isR15 = isR15
        self.isBoysLove = isBoysLove
        self.isGirlsLove = isGirlsLove
        self.isZankoku = isZankoku
        self.isTensei = isTensei
        self.isTenni = isTenni
        self.isIsekai = isIsekai
        self.charCount = charCount
        self.dialogueRatio = dialogueRatio
        self.illustrationCount = illustrationCount
        self.readingTime = readingTime
        self.publicationType = publicationType
        self.compositionStyle = compositionStyle
        self.isHiatus = isHiatus
        self.recentUpdate = recentUpdate
        self.recentUpdateUnix = recentUpdateUnix
        self.isPickup = isPickup
        self.responseFormat = responseFormat
    }
}
