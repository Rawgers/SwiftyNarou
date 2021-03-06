//
//  FetchSectionDataTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/9/20.
//

import XCTest
@testable import SwiftyNarou

class FetchSectionDataTest: XCTestCase {
    func testFetchSectionData() {
        let expectation = self.expectation(description: "Fetching section.")
        let url = URL(string: "https://ncode.syosetu.com/n4251cr/2")!
        Narou.fetchNarou(url: url) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertTrue(String(data: data!, encoding: .utf8)! != "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchSectionContent() {
        let expectation = self.expectation(description: "Fetching section.")
        let ncode = "n4251cr/2"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(error)
            XCTAssertNotNil(content)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchSectionDataWithFurigana() {
        let expectation = self.expectation(description: "Fetching section.")
        let ncode = "n5092gl/18"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(error)
            XCTAssertNotNil(content)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSectionDataInvalidNcode() {
        // Ncode is empty string.
        var expectation = self.expectation(description: "Fetching section.")
        var ncode = ""
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Ncode insufficinet path components.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "n5092gl18"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Ncode too many path components.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "n5092gl/1/8"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Missing "n" or "N" as ncode prefix.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "5092gl/18"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Second path component is not a number.
        expectation = self.expectation(description: "Fetching section.")
        ncode = "n5092gl/a"
        Narou.fetchSectionData(ncode: ncode) { content, error in
            XCTAssertNil(content)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
