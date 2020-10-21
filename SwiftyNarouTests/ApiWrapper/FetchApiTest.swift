//
//  FetchApiTest.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/21/20.
//

import XCTest
import Gzip
@testable import SwiftyNarou

class FetchApiTest: XCTestCase {
    let narou = Narou()
    
    func testFetchNarouApiJson() {
        let expectation = self.expectation(description: "Fetching api.")
        let request = NarouRequest(
            responseFormat: NarouResponseFormat(
                fileFormat: .JSON,
                limit: 50
            )
        )
        narou.fetchNarouApi(request: request) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertEqual(data!.count, 50)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchNarouApiCompressed() {
        let expectation = self.expectation(description: "Fetching api.")
        let request = NarouRequest(
            responseFormat: NarouResponseFormat(
                gzipCompressionLevel: 5,
                fileFormat: .JSON,
                limit: 5
            )
        )
        narou.fetchNarouApi(request: request) { data, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertEqual(data!.count, 5)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
