//
//  NarouNovelFetcher.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/3/20.
//

import SwiftSoup

public class Narou {
    let session: URLSession = URLSession.shared
    var task: URLSessionDataTask?
    
    init() {
        SwiftSoup.OutputSettings().prettyPrint(pretty: false)
    }
}
