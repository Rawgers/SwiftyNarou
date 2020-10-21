//
//  FetchNovelIndexDataTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/6/20.
//

import XCTest
@testable import SwiftyNarou

class FetchNovelIndexDataTest: XCTestCase {
    var narou: Narou!
    
    override func setUp() {
        narou = Narou()
    }

    func testfetchNovelIndexData() {
        let expectation = self.expectation(description: "Fetching novel index.")
        let url = URL(string: "https://ncode.syosetu.com/n4251cr/")!
        narou.fetchNarou(url: url) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(String(data: data!, encoding: .utf8)! != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
