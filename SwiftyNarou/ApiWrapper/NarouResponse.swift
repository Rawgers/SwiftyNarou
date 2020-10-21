//
//  NarouResponse.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/11/20.
//

public struct NarouResponse: Equatable {
    // novel title
    public let title: String?

    // starts with 'n'
    public let ncode: String?

    // author's identification in Narou's database
    public let userId: Int?

    // author
    public let author: String?

    // synopsis
    public let synopsis: String?

    // major genre categories
    public let biggenre: BigGenre?

    // more granular breakdown of genre categories
    public let genre: Genre?

    // various tags assigned to a novel
    public let keyword: [String]?

    // first upload date
    public let firstUpload: Date?

    // last upload date
    public let lastUpload: Date?

    // the type of novel; 1 = series, 2 = short story
    public let novelType: NovelType?

    // true if the novel is completed
    public let hasEnded: Bool?

    // number of sections
    public let sectionCount: Int?

    // number of characters
    public let charCount: Int?

    // estimated time to read the novel, calculated by length % 500
    public let readingTime: Int?

    // true if the novel is on hiatus
    public let isOnHiatus: Bool?

    // true if the novel is only suitable for ages 15+
    public let isR15: Bool?

    // true if the novel contains romance between gay males
    public let isBoysLove: Bool?

    // true if the novel contains romance between gay females
    public let isGirlsLove: Bool?

    // true if the novel has tragic themes
    public let isZankoku: Bool?

    // true if the novel has reincarnation themes
    public let isTensei: Bool?

    // true if the novel has transported-to-another-world themes
    public let isTenni: Bool?
    
    // the device used to submit the novel
    public let pcOrK: PcOrK?

    // total rating points, calculated by 2 * favorites + review points
    public let totalPoints: Int?

    // number of rating points received in the past 24 hours
    public let dailyPoints: Int?
    
    // number of rating points received in the past 7 days
    public let weeklyPoints: Int?
    
    // number of rating points received in the past 30 days
    public let monthlyPoints: Int?
    
    // number of rating points received in the past 90 days
    public let quarterlyPoints: Int?
    
    // number of rating points received in the past 365 days
    public let yearlyPoints: Int?
    
    // number of times favorited
    public let favoriteCount: Int?
    
    // number of reactions
    public let reactCount: Int?
    
    // number of reviews
    public let reviewCount: Int?
    
    // total review points
    public let totalReviewPoints: Int?
    
    // number of reviewers
    public let reviewerCount: Int?
    
    // number of illustrations
    public let illustrationCount: Int?
    
    // the dialogue-to-text ratio
    public let dialogueRatio: Int?
    
    // most recent update date, same as `generalLastup`?
    public let lastUpdate: Date?
    
    // most recent edit date
    public let lastEdit: Date?
    
    init(
        title: String? = nil,
        ncode: String? = nil,
        userId: Int? = nil,
        author: String? = nil,
        synopsis: String? = nil,
        biggenre: BigGenre? = nil,
        genre: Genre? = nil,
        keyword: [String]? = nil,
        firstUpload: Date? = nil,
        lastUpload: Date? = nil,
        novelType: NovelType? = nil,
        hasEnded: Bool? = nil,
        sectionCount: Int? = nil,
        charCount: Int? = nil,
        readingTime: Int? = nil,
        isOnHiatus: Bool? = nil,
        isR15: Bool? = nil,
        isBoysLove: Bool? = nil,
        isGirlsLove: Bool? = nil,
        isZankoku: Bool? = nil,
        isTensei: Bool? = nil,
        isTenni: Bool? = nil,
        pcOrK: PcOrK? = nil,
        totalPoints: Int? = nil,
        dailyPoints: Int? = nil,
        weeklyPoints: Int? = nil,
        monthlyPoints: Int? = nil,
        quarterlyPoints: Int? = nil,
        yearlyPoints: Int? = nil,
        favoriteCount: Int? = nil,
        reactCount: Int? = nil,
        reviewCount: Int? = nil,
        totalReviewPoints: Int? = nil,
        reviewerCount: Int? = nil,
        illustrationCount: Int? = nil,
        dialogueRatio: Int? = nil,
        lastUpdate: Date? = nil,
        lastEdit: Date? = nil
    ) {
        self.title = title
        self.ncode = ncode
        self.userId = userId
        self.author = author
        self.synopsis = synopsis
        self.biggenre = biggenre
        self.genre = genre
        self.keyword = keyword
        self.firstUpload = firstUpload
        self.lastUpload = lastUpload
        self.novelType = novelType
        self.hasEnded = hasEnded
        self.sectionCount = sectionCount
        self.charCount = charCount
        self.readingTime = readingTime
        self.isOnHiatus = isOnHiatus
        self.isR15 = isR15
        self.isBoysLove = isBoysLove
        self.isGirlsLove = isGirlsLove
        self.isZankoku = isZankoku
        self.isTensei = isTensei
        self.isTenni = isTenni
        self.pcOrK = pcOrK
        self.totalPoints = totalPoints
        self.dailyPoints = dailyPoints
        self.weeklyPoints = weeklyPoints
        self.monthlyPoints = monthlyPoints
        self.quarterlyPoints = quarterlyPoints
        self.yearlyPoints = yearlyPoints
        self.favoriteCount = favoriteCount
        self.reactCount = reactCount
        self.reviewCount = reviewCount
        self.totalReviewPoints = totalReviewPoints
        self.reviewerCount = reviewerCount
        self.illustrationCount = illustrationCount
        self.dialogueRatio = dialogueRatio
        self.lastUpdate = lastUpdate
        self.lastEdit = lastEdit
    }
    
    public static func == (lhs: NarouResponse, rhs: NarouResponse) -> Bool {
        return lhs.title == rhs.title
            && lhs.ncode == rhs.ncode
            && lhs.userId == rhs.userId
            && lhs.author == rhs.author
            && lhs.synopsis == rhs.synopsis
            && lhs.biggenre == rhs.biggenre
            && lhs.genre == rhs.genre
            && lhs.keyword == rhs.keyword
            && lhs.lastUpload == rhs.lastUpload
            && lhs.novelType == rhs.novelType
            && lhs.hasEnded == rhs.hasEnded
            && lhs.sectionCount == rhs.sectionCount
            && lhs.charCount == rhs.charCount
            && lhs.readingTime == rhs.readingTime
            && lhs.isOnHiatus == rhs.isOnHiatus
            && lhs.isR15 == rhs.isR15
            && lhs.isBoysLove == rhs.isGirlsLove
            && lhs.isZankoku == rhs.isZankoku
            && lhs.isTensei == rhs.isTensei
            && lhs.isTenni == rhs.isTenni
            && lhs.pcOrK == rhs.pcOrK
            && lhs.totalPoints == rhs.totalPoints
            && lhs.dailyPoints == rhs.dailyPoints
            && lhs.weeklyPoints == rhs.weeklyPoints
            && lhs.monthlyPoints == rhs.monthlyPoints
            && lhs.quarterlyPoints == rhs.quarterlyPoints
            && lhs.yearlyPoints == rhs.yearlyPoints
            && lhs.favoriteCount == rhs.favoriteCount
            && lhs.reactCount == rhs.reactCount
            && lhs.reviewCount == rhs.reviewCount
            && lhs.totalReviewPoints == rhs.totalReviewPoints
            && lhs.reviewerCount == rhs.reviewerCount
            && lhs.illustrationCount == rhs.illustrationCount
            && lhs.dialogueRatio == rhs.dialogueRatio
            && lhs.lastUpdate == rhs.lastUpdate
            && lhs.lastEdit == rhs.lastEdit
    }
}


