//
//  GenerateQueryItemsTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/14/20.
//

import XCTest
@testable import SwiftyNarou

class GenerateQueryItemsTest: XCTestCase {
    let narou = Narou()

    func testGenerateUrlWithNcode() {
        var request = NarouRequest(
            ncode: ["n9669bk"]
        )
        var expectedUrl = formatUrl("ncode=n9669bk")
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            ncode: ["n9669bk", "n1075ge"]
        )
        expectedUrl = formatUrl("ncode=n9669bk-n1075ge")
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }

    func testGenerateUrlWithUserId() {
        var request = NarouRequest(
            userId: ["288399"]
        )
        var expectedUrl = formatUrl("userid=288399")
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            userId: ["288399", "1561197"]
        )
        expectedUrl = formatUrl("userid=288399-1561197")
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
    
    // Also tests generating queries with multiple parameters.
    func testGenerateUrlWithWord() {
        let request = NarouRequest(
            word: "僕たち",
            notWord: "彼女",
            inText: [.title, .synopsis]
        )
        let expectedUrl = formatUrl("word=僕たち&notword=彼女&title=1&ex=1")
        let url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
    
    func testGenerateUrlWithGenre() {
        var request = NarouRequest(
            bigGenre: [.romance, .scifi]
        )
        var expectedUrl = formatUrl("biggenre=1-4")
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            notBigGenre: [.fantasy, .literature]
        )
        expectedUrl = formatUrl("notbiggenre=2-3")
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            genre: [.fantasyHigh, .scifiVr]
        )
        expectedUrl = formatUrl("genre=201-401")
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            notGenre: [.literatureMystery, .none]
        )
        expectedUrl = formatUrl("notgenre=304-9801")
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
    
    func testGenerateUrlWithTheme() {
        var request = NarouRequest(
            isR15: true,
            isBoysLove: true,
            isGirlsLove: true,
            isZankoku: true,
            isIsekai: true
        )
        var expectedUrl = formatUrl(
            "isr15=1&" +
            "isbl=1&" +
            "isgl=1&" +
            "iszankoku=1&" +
            "istt=1"
        )
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            isR15: false,
            isBoysLove: false,
            isGirlsLove: false,
            isZankoku: false,
            isTensei: false,
            isTenni: false
        )
        expectedUrl = formatUrl(
            "notr15=1&" +
            "notbl=1&" +
            "notgl=1&" +
            "notzankoku=1&" +
            "nottensei=1&" +
            "nottenni=1"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
    
    func testGenerateUrlWithContentMetadata() {
        // test `length` and range min and max defined
        var request = NarouRequest(
            charCount: (5000, 15000)
        )
        var expectedUrl = formatUrl(
            "length=5000-15000"
        )
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        // test `kaiwaritu` and range min undefined
        request = NarouRequest(
            dialogueRatio: (nil, 30)
        )
        expectedUrl = formatUrl(
            "kaiwaritu=-30"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        // test `sasie` and range max undefined
        request = NarouRequest(
            illustrationCount: (6, nil)
        )
        expectedUrl = formatUrl(
            "sasie=6-"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            readingTime: (1600000000, 1603070228)
        )
        expectedUrl = formatUrl(
            "time=1600000000-1603070228"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            publicationType: .completed
        )
        expectedUrl = formatUrl(
            "type=ter"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            compositionStyle: [
                .noIndentationAndManyConsecutiveLineBreaks,
                .noIndentationAndAverageLineBreaks,
                .indentationAndManyConsecutiveLineBreaks,
                .indentationAndAverageLineBreaks
            ]
        )
        expectedUrl = formatUrl(
            "buntai=1-2-4-6"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
    
    func testGenerateUrlWithStatus() {
        var request = NarouRequest(
            isHiatus: true
        )
        var expectedUrl = formatUrl(
            "stop=2"
        )
        var url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            recentUpdate: .lastWeek
        )
        expectedUrl = formatUrl(
            "lastUp=lastweek"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            recentUpdateUnix: (1262271600, 1264949999)
        )
        expectedUrl = formatUrl(
            "lastUp=1262271600-1264949999"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
        
        request = NarouRequest(
            isPickup: true
        )
        expectedUrl = formatUrl(
            "ispickup=1"
        )
        url = narou.generateRequestUrl(from: request)
        XCTAssertEqual(url.absoluteString, expectedUrl)
    }
}
