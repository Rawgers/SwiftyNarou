//
//  Narou+ParseYaml.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/19/20.
//

import SwiftyJSON

extension Narou {
    static func parseJsonResponse(_ response: Data) -> (Int, [NarouResponse]) {
        let json = try? JSON(data: response)
        let novels = json?.array ?? []
        
        var parsedResponses = [NarouResponse]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let count = novels[0]["allcount"].int ?? 0
        for novel in novels[1...] {
            let genreValue = novel["biggenre"].int
            let subgenreValue = novel["genre"].int
            let keywordValue = novel["keyword"].string
            let firstUploadValue = novel["general_firstup"].string
            let lastUploadValue = novel["general_lastup"].string
            let novelTypeValue = novel["novel_type"].int
            let hasEndedValue = novel["end"].int
            let isOnHiatusValue = novel["isstop"].int
            let isR15Value = novel["isr15"].int
            let isBoysLoveValue = novel["isbl"].int
            let isGirlsLoveValue = novel["isgl"].int
            let isZankokuValue = novel["iszankoku"].int
            let isTenseiValue = novel["istensei"].int
            let isTenniValue = novel["istenni"].int
            let pcOrKValue = novel["pc_or_k"].int
            let lastUpdateValue = novel["novelupdated_at"].string
            let lastEditValue = novel["updated_at"].string
            
            let parsedResponse = NarouResponse(
                title: novel["title"].string,
                ncode: novel["ncode"].string,
                userId: novel["userid"].int,
                author: novel["writer"].string,
                synopsis: novel["story"].string,
                genre: genreValue != nil
                    ? Genre(rawValue: genreValue!)
                    : nil,
                subgenre: subgenreValue != nil
                    ? Subgenre(rawValue: subgenreValue!)
                    : nil,
                keyword: keywordValue != nil
                    ? keywordValue!.components(separatedBy: " ")
                    : nil,
                firstUpload: firstUploadValue != nil
                    ? dateFormatter.date(from: firstUploadValue!)
                    : nil,
                lastUpload: lastUploadValue != nil
                    ? dateFormatter.date(from: lastUploadValue!)
                    : nil,
                novelType: novelTypeValue != nil
                    ? NovelType(rawValue: novelTypeValue!)
                    : nil,
                hasEnded: hasEndedValue != nil
                    ? hasEndedValue == 1
                    : nil,
                sectionCount: novel["general_all_no"].int,
                charCount: novel["length"].int,
                readingTime: novel["time"].int,
                isOnHiatus: isOnHiatusValue != nil
                    ? isOnHiatusValue == 1
                    : nil,
                isR15: isR15Value != nil
                    ? isR15Value == 1
                    : nil,
                isBoysLove: isBoysLoveValue != nil
                    ? isBoysLoveValue == 1
                    : nil,
                isGirlsLove: isGirlsLoveValue != nil
                    ? isGirlsLoveValue == 1
                    : nil,
                isZankoku: isZankokuValue != nil
                    ? isZankokuValue == 1
                    : nil,
                isTensei: isTenseiValue != nil
                    ? isTenseiValue == 1
                    : nil,
                isTenni: isTenniValue != nil
                    ? isTenniValue == 1
                    : nil,
                pcOrK: pcOrKValue != nil
                    ? PcOrK(rawValue: pcOrKValue!)
                    : nil,
                totalPoints: novel["global_point"].int,
                dailyPoints: novel["daily_point"].int,
                weeklyPoints: novel["weekly_point"].int,
                monthlyPoints: novel["monthly_point"].int,
                quarterlyPoints: novel["quarter_point"].int,
                yearlyPoints: novel["yearly_point"].int,
                favoriteCount: novel["fav_novel_cnt"].int,
                reactCount: novel["impression_cnt"].int,
                reviewCount: novel["review_cnt"].int,
                totalReviewPoints: novel["all_point"].int,
                reviewerCount: novel["all_hyoka_cnt"].int,
                illustrationCount: novel["sasie_cnt"].int,
                dialogueRatio: novel["kaiwaritu"].int,
                lastUpdate: lastUpdateValue != nil
                    ? dateFormatter.date(from: lastUpdateValue!)
                    : nil,
                lastEdit: lastEditValue != nil
                    ? dateFormatter.date(from: lastEditValue!)
                    : nil
            )
            parsedResponses.append(parsedResponse)
        }

        return (count, parsedResponses)
    }
}
