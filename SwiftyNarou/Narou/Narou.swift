//
//  NarouNovelFetcher.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/3/20.
//

import SwiftSoup

public class Narou {
    let session: URLSession = URLSession.shared
    
    func fetchNarou(
        url: URL,
        _ completionHandler: @escaping (Data?, Error?) -> Void
    ) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(
                    nil,
                    NarouError.ClientError(message: error.localizedDescription)
                )
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            if !(200...299).contains(httpResponse.statusCode) {
                completionHandler(
                    nil,
                    NarouError.ServerError(errorCode: httpResponse.statusCode)
                )
                return
            }
            
            if let contentData = data {
                completionHandler(contentData, nil)
            } else {
                completionHandler(
                    nil,
                    NarouError.ContentError(badData: data?.debugDescription ?? "")
                )
            }
        }
        task.resume()
    }
}
