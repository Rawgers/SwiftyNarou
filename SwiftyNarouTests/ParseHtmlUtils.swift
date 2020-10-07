//
//  ParseHtmlUtils.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/6/20.
//

import SwiftSoup
import XCTest

func selectFragment(_ html: String) -> Element {
    let doc = try! SwiftSoup.parseBodyFragment(html)
    return try! doc.select("body").first()!.child(0)
}
