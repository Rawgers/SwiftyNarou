//
//  NarouResponse.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/11/20.
//

public struct NarouResponse {
    // novel title
    let title: String?

    // starts with 'n'
    let ncode: String?

    // author's identification in Narou's database
    let userId: String?

    // author
    let writer: String?

    // synopsis
    let story: String?

    // major genre categories
    let biggenre: BigGenre?

    // more granular breakdown of genre categories
    let genre: Genre?

    // various tags assigned to a novel
    let keyword: String?

    // first upload date
    let generalFirstup: Date?

    // last upload date
    let generalLastup: String?

    // the type of novel; 1 = series, 2 = short story
    let novelType: NovelType?

    // true if the novel is completed
    let end: Bool?

    // number of sections
    let generalAllNo: Int?

    // number of characters
    let length: Int?

    // estimated time to read the novel, calculated by length % 500
    let time: Int?

    // true if the novel is on hiatus
    let isStop: Bool?

    // true if the novel is only suitable for ages 15+
    let isR15: Bool?

    // true if the novel contains romance between gay males
    let isBl: Bool?

    // true if the novel contains romance between gay females
    let isGl: Bool?

    // true if the novel has tragic themes
    let isZankoku: Bool?

    // true if the novel has reincarnation themes
    let isTensei: Bool?

    // true if the novel has transported-to-another-world themes
    let isTenni: Bool?
    
    // the device used to submit the novel
    let pcOrK: PcOrK?

    // total rating points, calculated by 2 * favorites + review points
    let globalPoint: Int?

    // number of rating points received in the past 24 hours
    let dailyPoint: Int?
    
    // number of rating points received in the past 7 days
    let weeklyPoint: Int?
    
    // number of rating points received in the past 30 days
    let monthlyPoint: Int?
    
    // number of rating points received in the past 90 days
    let quarterlyPoint: Int?
    
    // number of rating points received in the past 365 days
    let yearlyPoint: Int?
    
    // number of times favorited
    let favNovelCnt: Int?
    
    // number of reactions
    let impressionCnt: Int?
    
    // number of reviews
    let reviewCnt: Int?
    
    // total review points
    let allPoint: Int?
    
    // number of reviewers
    let allHyokaCnt: Int?
    
    // number of illustrations
    let sasieCnt: Int?
    
    // the dialogue-to-text ratio
    let kaiwaritu: Float?
    
    // most recent update date, same as `generalLastup`?
    let novelupdatedAt: Date?
    
    // most recent edit date
    let updatedAt: Date?
}
