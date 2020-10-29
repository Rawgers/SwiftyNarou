//
//  Narou+ApiWrapper.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/13/20.
//

extension Narou {
    public static func fetchNarouApi(
        request: NarouRequest,
        _ completion: @escaping ([NarouResponse]?, Error?) -> Void
    ) {
        fetchNarouApiRaw(request: request) { data, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
                return
            }
            
            if request.responseFormat?.gzipCompressionLevel != nil {
                data = gunzip(data)
            }
            
            let response: [NarouResponse]
            switch request.responseFormat?.fileFormat {
            case .JSON:
                response = self.parseJsonResponse(data)
            default:
                response = []
            }
            
            DispatchQueue.main.async {
                completion(response, error)
                return
            }
        }
    }
    
    public static func fetchNarouApiRaw(
        request: NarouRequest,
        _ completion: @escaping (Data?, Error?) -> Void
    ) {
        let url = generateRequestUrl(from: request)
        fetchNarou(url: url) { data, error in
            completion(data, error)
        }
    }
    
    static func generateRequestUrl(from request: NarouRequest) -> URL {
        var urlComponents = URLComponents(string: Constants.SYOSETU_API_URL)!
        let queryItems = generateQueryItems(from: request)
        urlComponents.queryItems = queryItems
        return (urlComponents.url?.absoluteURL)!
    }
    
    private static func generateQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let format = request.responseFormat {
            queryItems += generateResponseFormatQueryItems(from: format)
        }
        
        queryItems += generateIdQueryItems(from: request)
        queryItems += generateTextQueryItems(from: request)
        queryItems += generateGenreQueryItems(from: request)
        queryItems += generateThemeQueryItems(from: request)
        queryItems += generateContentMetadataQueryItems(from: request)
        queryItems += generateStatusQueryItems(from: request)
        
        return queryItems
    }
    
    private static func generateIdQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let ncode = request.ncode {
            queryItems.append(URLQueryItem(
                name: "ncode",
                value: ncode.joined(separator: "-")
            ))
        }
        
        if let userId = request.userId {
            queryItems.append(URLQueryItem(
                name: "userid",
                value: userId.joined(separator: "-")
            ))
        }
        
        return queryItems
    }
    
    private static func generateTextQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let word = request.word {
            queryItems.append(URLQueryItem(
                name: "word",
                value: word
            ))
        }
        
        if let notWord = request.notWord {
            queryItems.append(URLQueryItem(
                name: "notword",
                value: notWord
            ))
        }
        
        if let inText = request.inText {
            inText.forEach {
                queryItems.append(URLQueryItem(
                    name: $0.rawValue,
                    value: "1"
                ))
            }
        }
        
        return queryItems
    }
    
    private static func generateGenreQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let genre = request.genre {
            queryItems.append(URLQueryItem(
                name: "biggenre",
                value: genre.map {
                    String($0.rawValue)
                }.joined(separator: "-")
            ))
        }
        
        if let notGenre = request.notGenre {
            queryItems.append(URLQueryItem(
                name: "notbiggenre",
                value: notGenre.map {
                    String($0.rawValue)
                }.joined(separator: "-")
            ))
        }
        
        if let subgenre = request.subgenre {
            queryItems.append(URLQueryItem(
                name: "genre",
                value: subgenre.map {
                    String($0.rawValue)
                }.joined(separator: "-")
            ))
        }
        
        if let notSubgenre = request.notSubgenre {
            queryItems.append(URLQueryItem(
                name: "notgenre",
                value: notSubgenre.map {
                    String($0.rawValue)
                }.joined(separator: "-")
            ))
        }
        
        return queryItems
    }
    
    private static func generateThemeQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let isR15 = request.isR15 {
            queryItems.append(URLQueryItem(
                name: isR15 ? "isr15" : "notr15",
                value: "1"
            ))
        }
        
        if let isBoysLove = request.isBoysLove {
            queryItems.append(URLQueryItem(
                name: isBoysLove ? "isbl" : "notbl",
                value: "1"
            ))
        }
        
        if let isGirlsLove = request.isGirlsLove {
            queryItems.append(URLQueryItem(
                name: isGirlsLove ? "isgl" : "notgl",
                value: "1"
            ))
        }
        
        if let isZankoku = request.isZankoku {
            queryItems.append(URLQueryItem(
                name: isZankoku ? "iszankoku" : "notzankoku",
                value: "1"
            ))
        }
        
        if let isTensei = request.isTensei {
            queryItems.append(URLQueryItem(
                name: isTensei ? "istensei" : "nottensei",
                value: "1"
            ))
        }
        
        if let isTenni = request.isTenni {
            queryItems.append(URLQueryItem(
                name: isTenni ? "istenni" : "nottenni",
                value: "1"
            ))
        }
        
        if let isIsekai = request.isIsekai, isIsekai {
            queryItems.append(URLQueryItem(
                name: "istt",
                value: "1"
            ))
        }
        
        return queryItems
    }
    
    private static func generateContentMetadataQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let charCount = request.charCount {
            var range = ""
            if let min = charCount.min {
                range += String(min)
            }
            range += "-"
            if let max = charCount.max {
                range += String(max)
            }
            queryItems.append(URLQueryItem(
                name: "length",
                value: range
            ))
        }
        
        if let dialogueRatio = request.dialogueRatio {
            var range = ""
            if let min = dialogueRatio.min {
                range += String(min)
            }
            range += "-"
            if let max = dialogueRatio.max {
                range += String(max)
            }
            queryItems.append(URLQueryItem(
                name: "kaiwaritu",
                value: range
            ))
        }
        
        if let illustrationCount = request.illustrationCount {
            var range = ""
            if let min = illustrationCount.min {
                range += String(min)
            }
            range += "-"
            if let max = illustrationCount.max {
                range += String(max)
            }
            queryItems.append(URLQueryItem(
                name: "sasie",
                value: range
            ))
        }
        
        if let readingTime = request.readingTime {
            var range = ""
            if let min = readingTime.min {
                range += String(min)
            }
            range += "-"
            if let max = readingTime.max {
                range += String(max)
            }
            queryItems.append(URLQueryItem(
                name: "time",
                value: range
            ))
        }
        
        if let publicationType = request.publicationType {
            queryItems.append(URLQueryItem(
                name: "type",
                value: publicationType.rawValue
            ))
        }
        
        if let compositionStyle = request.compositionStyle {
            queryItems.append(URLQueryItem(
                name: "buntai",
                value: compositionStyle.map {
                    String($0.rawValue)
                }.joined(separator: "-")
            ))
        }
        
        return queryItems
    }
    
    private static func generateStatusQueryItems(
        from request: NarouRequest
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let isHiatus = request.isHiatus {
            queryItems.append(URLQueryItem(
                name: "stop",
                value: isHiatus ? "2" : "1"
            ))
        }
        
        if let recentUpdate = request.recentUpdate {
            queryItems.append(URLQueryItem(
                name: "lastUp",
                value: recentUpdate.rawValue
            ))
        } else if let recentUpdateUnix = request.recentUpdateUnix {
            var range = ""
            if let from = recentUpdateUnix.from {
                range += String(from)
            }
            range += "-"
            if let to = recentUpdateUnix.to {
                range += String(to)
            }
            queryItems.append(URLQueryItem(
                name: "lastUp",
                value: range
            ))
        }
        
        if let isPickup = request.isPickup, isPickup {
            queryItems.append(URLQueryItem(
                name: "ispickup",
                value: "1"
            ))
        }
        
        return queryItems
    }
    
    private static func generateResponseFormatQueryItems(
        from format: NarouResponseFormat
    ) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let gzip = format.gzipCompressionLevel {
            queryItems.append(URLQueryItem(
                name: "gzip",
                value: String(gzip)
            ))
        }
        
        if let fileFormat = format.fileFormat {
            queryItems.append(URLQueryItem(
                name: "out",
                value: fileFormat.rawValue
            ))
        }
        
        if let yamlStyle = format.yamlStyle {
            queryItems.append(URLQueryItem(
                name: "libtype",
                value: String(yamlStyle.rawValue)
            ))
        }
        
        if let fields = format.fields {
            queryItems.append(URLQueryItem(
                name: "of",
                value: fields.map {
                    $0.rawValue
                }.joined(separator: "-")
            ))
        }
        
        if let limit = format.limit {
            queryItems.append(URLQueryItem(
                name: "lim",
                value: String(limit)
            ))
        }
        
        if let start = format.startIndex {
            queryItems.append(URLQueryItem(
                name: "st",
                value: String(start)
            ))
        }
        
        if let order = format.order {
            queryItems.append(URLQueryItem(
                name: "order",
                value: order.rawValue
            ))
        }
        
        return queryItems
    }
}
