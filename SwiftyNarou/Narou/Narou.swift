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
    
    func fetchNcodeHtml(
        url: URL,
        _ completionHandler: @escaping (String?, Error?) -> Void
    ) {
        task?.cancel()
        
        task = session.dataTask(with: url) { data, response, error in
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
            
            if let mimeType = httpResponse.mimeType,
                mimeType != "text/html" {
                completionHandler(
                    nil,
                    NarouError.MimetypeError(incorrectMimetype: mimeType)
                )
                return
            }
            
            if let contentData = data,
                let content = String(data: contentData, encoding: .utf8) {
                completionHandler(content, nil)
            } else {
                completionHandler(
                    nil,
                    NarouError.ContentError(badData: data?.debugDescription ?? "")
                )
            }
        }
        
        task?.resume()
    }
}
