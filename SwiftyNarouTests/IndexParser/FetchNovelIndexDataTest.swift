//
//  FetchNovelIndexDataTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/6/20.
//

import XCTest
@testable import SwiftyNarou

class FetchNovelIndexDataTest: XCTestCase {
    func testfetchNovelIndexData() {
        let expectation = self.expectation(description: "Fetching novel index.")
        let url = URL(string: "https://ncode.syosetu.com/n4251cr/")!
        Narou.fetchNarou(url: url) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(String(data: data!, encoding: .utf8)! != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testNovelIndexInvalidNcode() {
        // Ncode is empty string.
        var expectation = self.expectation(description: "Fetching section.")
        var ncode = ""
        Narou.fetchNovelIndex(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Ncode too many path components.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "n5092gl/1/8"
        Narou.fetchNovelIndex(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Missing "n" or "N" as ncode prefix.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "5092gl/18"
        Narou.fetchNovelIndex(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
