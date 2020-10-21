//
//  YamlParserTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/20/20.
//

import XCTest
@testable import SwiftyNarou

class ParseJsonTest: XCTestCase {
    let narou = Narou()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    func testParseJsonResponseAllFields() {
        let json = #"""
        [
            {
                "allcount": 1
            },
            {
                "title": "\u82b1\u9ce5\u98a8\u6708\uff01\u3069\u3063\u304b\u3093\u5c4b",
                "ncode": "N2888FY",
                "userid": 867029,
                "writer": "\u821e\u6ca2\u6804",
                "story": "\u30fb1990\u5e74\u4ee3\u306e\u30e9\u30a4\u30c8\u30ce\u30d9\u30eb\u3084\u9ec4\u91d1\u671f\u5c11\u5e74\u30b8\u30e3\u30f3\u30d7\u306e\u3088\u3046\u306a\u30ce\u30ea\n\u30fb\u30d0\u30c8\u30eb\u3082\u306e\u306a\u306e\u306b\u5973\u6027\u30ad\u30e3\u30e9\u305f\u304f\u3055\u3093\n\u30fb\u5dfb\u3092\u8ffd\u3046\u3054\u3068\u306b\u30d1\u30ef\u30fc\u30a4\u30f3\u30d5\u30ec\n\u30fb\u30a2\u30e9\u30d5\u30a9\u30fc\u5411\u3051\u30ec\u30c8\u30ed\u30cd\u30bf\u6e80\u8f09\n\n\u3053\u3093\u306a\u611f\u3058\u3002",
                "biggenre": 2,
                "genre": 202,
                "gensaku": "",
                "keyword": "\u30e9\u30d6\u30b3\u30e1 \u30ae\u30e3\u30b0 \u5b66\u5712 \u73fe\u4ee3 \u8d85\u80fd\u529b \u30c0\u30f3\u30b8\u30e7\u30f3 \u5e7c\u99b4\u67d3\u307f \u59c9\u5f1f",
                "general_firstup": "2020-01-01 00:00:00",
                "general_lastup": "2020-10-20 17:18:14",
                "novel_type": 1,
                "end": 1,
                "general_all_no": 85,
                "length": 338736,
                "time": 678,
                "isstop": 0,
                "isr15": 0,
                "isbl": 0,
                "isgl": 0,
                "iszankoku": 0,
                "istensei": 0,
                "istenni": 0,
                "pc_or_k": 2,
                "global_point": 13,
                "daily_point": 0,
                "weekly_point": 0,
                "monthly_point": 0,
                "quarter_point": 2,
                "yearly_point": 13,
                "fav_novel_cnt": 3,
                "impression_cnt": 0,
                "review_cnt": 0,
                "all_point": 7,
                "all_hyoka_cnt": 1,
                "sasie_cnt": 0,
                "kaiwaritu": 40,
                "novelupdated_at": "2020-10-20 20:05:57",
                "updated_at": "2020-10-20 20:08:05"
            }
        ]
        """#.replacingOccurrences(of: "    ", with: "")
            .data(using: .utf8)!
        
        let expected = NarouResponse(
            title: "花鳥風月！どっかん屋",
            ncode: "N2888FY",
            userId: 867029,
            author: "舞沢栄",
            synopsis: "・1990年代のライトノベルや黄金期少年ジャンプのようなノリ\n・バトルものなのに女性キャラたくさん\n・巻を追うごとにパワーインフレ\n・アラフォー向けレトロネタ満載\n\nこんな感じ。",
            biggenre: .fantasy,
            genre: .fantasyLow,
            keyword: ["ラブコメ", "ギャグ", "学園", "現代", "超能力", "ダンジョン", "幼馴染み", "姉弟"],
            firstUpload: dateFormatter.date(from: "2020-01-01 00:00:00"),
            lastUpload: dateFormatter.date(from: "2020-10-20 17:18:14"),
            novelType: .series,
            hasEnded: true,
            sectionCount: 85,
            charCount: 338736,
            readingTime: 678,
            isOnHiatus: false,
            isR15: false,
            isBoysLove: false,
            isGirlsLove: false,
            isZankoku: false,
            isTensei: false,
            isTenni: false,
            pcOrK: .pc,
            totalPoints: 13,
            dailyPoints: 0,
            weeklyPoints: 0,
            monthlyPoints: 0,
            quarterlyPoints: 2,
            yearlyPoints: 13,
            favoriteCount: 3,
            reactCount: 0,
            reviewCount: 0,
            totalReviewPoints: 7,
            reviewerCount: 1,
            illustrationCount: 0,
            dialogueRatio: 40,
            lastUpdate: dateFormatter.date(from: "2020-10-20 20:05:57"),
            lastEdit: dateFormatter.date(from: "2020-10-20 20:08:05")
        )
        
        let res = narou.parseJsonResponse(json)
        XCTAssertEqual(res[0], expected)
    }
    
    func testParseJsonResponseMissingFields() {
        let json = #"""
        [
            {
                "allcount": 1
            },
            {
                "title": "\u82b1\u9ce5\u98a8\u6708\uff01\u3069\u3063\u304b\u3093\u5c4b",
                "ncode": "N2888FY",
                "userid": 867029,
                "writer": "\u821e\u6ca2\u6804",
            }
        ]
        """#.replacingOccurrences(of: "    ", with: "")
            .data(using: .utf8)!
        
        let expected = NarouResponse(
            title: "花鳥風月！どっかん屋",
            ncode: "N2888FY",
            userId: 867029,
            author: "舞沢栄"
        )
        
        let res = narou.parseJsonResponse(json)
        XCTAssertEqual(res[0], expected)
    }
}
