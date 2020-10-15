//
//  ParseHtmlUtils.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/6/20.
//

import SwiftSoup
@testable import SwiftyNarou

func selectFragment(_ html: String) -> Element {
    let doc = try! SwiftSoup.parseBodyFragment(html)
    return try! doc.select("body").first()!.child(0)
}

func formatUrl(_ query: String) -> String {
    return (Constants.SYOSETU_API_URL + query)
        .addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )!
}
