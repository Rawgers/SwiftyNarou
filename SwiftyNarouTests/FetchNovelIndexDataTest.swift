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
    
    override func setUpWithError() throws {
        narou = Narou()
    }

    func testfetchNovelIndexData() {
        let expectation = self.expectation(description: "Fetching novel index.")
        let url = URL(string: "https://ncode.syosetu.com/n4251cr/")!
        narou.fetchNovelIndexData(url: url) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(data != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testfetchNovelIndexData2() {
        let expectation = self.expectation(description: "Fetching novel index.")
        let url = URL(string: "https://ncode.syosetu.com/n7812gj/")!
        narou.fetchNovelIndexData(url: url) { data, error in
            print(data!)
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(data != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
