//
//  FetchSectionContentTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/9/20.
//

import XCTest
@testable import SwiftyNarou

class FetchSectionContentTest: XCTestCase {
    var narou: Narou!
    
    override func setUp() {
        narou = Narou()
    }

    func testFetchSectionContentData() {
        let expectation = self.expectation(description: "Fetching section.")
        let url = URL(string: "https://ncode.syosetu.com/n4251cr/2")!
        narou.fetchNcodeHtml(url: url) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(data != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchSectionContent() {
        let expectation = self.expectation(description: "Fetching section.")
        let ncode = "n4251cr/2"
        narou.fetchSectionContent(ncode: ncode) { content, error in
            XCTAssertNil(error)
            XCTAssertNotNil(content)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchSectionContentWithFurigana() {
        let expectation = self.expectation(description: "Fetching section.")
        let ncode = "n5092gl/18"
        narou.fetchSectionContent(ncode: ncode) { content, error in
            XCTAssertNil(error)
            XCTAssertNotNil(content)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
