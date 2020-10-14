//
//  NarouResponse.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/11/20.
//

public struct NarouResponse {
    // novel title
    public let title: String?

    // starts with 'n'
    public let ncode: String?

    // author's identification in Narou's database
    public let userId: String?

    // author
    public let writer: String?

    // synopsis
    public let story: String?

    // major genre categories
    public let biggenre: BigGenre?

    // more granular breakdown of genre categories
    public let genre: Genre?

    // various tags assigned to a novel
    public let keyword: String?

    // first upload date
    public let generalFirstup: Date?

    // last upload date
    public let generalLastup: String?

    // the type of novel; 1 = series, 2 = short story
    public let novelType: NovelType?

    // true if the novel is completed
    public let end: Bool?

    // number of sections
    public let generalAllNo: Int?

    // number of characters
    public let length: Int?

    // estimated time to read the novel, calculated by length % 500
    public let time: Int?

    // true if the novel is on hiatus
    public let isStop: Bool?

    // true if the novel is only suitable for ages 15+
    public let isR15: Bool?

    // true if the novel contains romance between gay males
    public let isBl: Bool?

    // true if the novel contains romance between gay females
    public let isGl: Bool?

    // true if the novel has tragic themes
    public let isZankoku: Bool?

    // true if the novel has reincarnation themes
    public let isTensei: Bool?

    // true if the novel has transported-to-another-world themes
    public let isTenni: Bool?
    
    // the device used to submit the novel
    public let pcOrK: PcOrK?

    // total rating points, calculated by 2 * favorites + review points
    public let globalPoint: Int?

    // number of rating points received in the past 24 hours
    public let dailyPoint: Int?
    
    // number of rating points received in the past 7 days
    public let weeklyPoint: Int?
    
    // number of rating points received in the past 30 days
    public let monthlyPoint: Int?
    
    // number of rating points received in the past 90 days
    public let quarterlyPoint: Int?
    
    // number of rating points received in the past 365 days
    public let yearlyPoint: Int?
    
    // number of times favorited
    public let favNovelCnt: Int?
    
    // number of reactions
    public let impressionCnt: Int?
    
    // number of reviews
    public let reviewCnt: Int?
    
    // total review points
    public let allPoint: Int?
    
    // number of reviewers
    public let allHyokaCnt: Int?
    
    // number of illustrations
    public let sasieCnt: Int?
    
    // the dialogue-to-text ratio
    public let kaiwaritu: Float?
    
    // most recent update date, same as `generalLastup`?
    public let novelupdatedAt: Date?
    
    // most recent edit date
    public let updatedAt: Date?
}
