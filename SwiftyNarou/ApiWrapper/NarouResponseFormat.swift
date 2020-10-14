//
//  NarouResponseFormat.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/13/20.
//

public enum ResponseFileFormat: String {
    case YAML = "yaml"
    case JSON = "json"
    case PHP = "php"
    case atom = "atom"
    case JSONP = "jsonp"
}

public enum ResponseFieldSelection: String {
    case novelTitle = "t"
    case ncode = "n"
    case userId = "u"
    case author = "w"
    case synopsis = "s"
    case bigGenre = "bg"
    case genre = "g"
    case tags = "k"
    case firstUpload = "gf"
    case lastUpload = "gl"
    case novelType = "nt"
    case hasEnded = "e"
    case sectionCount = "ga"
    case charCount = "l"
    case readingTime = "ti"
    case isOnHiatus = "i"
    case isR15 = "ir"
    case isBoysLove = "ibl"
    case isGirlsLove = "igl"
    case isZankoku = "izk"
    case isTensei = "its"
    case isTenni = "iti"
    case pcOrK = "p"
    case totalPoints = "gp"
    case dailyPoints = "dp"
    case weeklyPoints = "wp"
    case monthlyPoints = "mp"
    case quaterlyPoints = "qp"
    case yearlyPoints = "yp"
    case favoriteCount = "f"
    case reactCount = "imp"
    case reviewCount = "r"
    case totalReviewPoints = "a"
    case reviewerCount = "ah"
    case illustrationCount = "sa"
    case dialogueRatio = "ka"
    case lastUpdate = "nu"
    case lastEdit = "ua"
}

public enum ResponseOrder: String {
    case mostRecentUpdate = "new"
    case mostFavorites = "favnovelcnt"
    case highestReviews = "reviewcnt"
    case highestRating = "hyoka"
    case lowestRating = "hyokaasc"
    case mostPointsDay = "dailyPoint"
    case mostPointsWeek = "weeklypoint"
    case mostPointsMonth = "monthlypoint"
    case mostPointsQuarter = "quarterpoint"
    case mostPointsYear = "yearlypoint"
    case mostReactions = "impressioncnt"
    case mostReviewers = "hyokacnt"
    case fewestReviewers = "hyokacntasc"
    case mostPopularWeek = "weekly"
    case mostCharacters = "lengthdesc"
    case fewestCharacters = "lengthasc"
    case newestPublish = "ncodedesc"
    case leastRecentUpdate = "old"
}

public struct NarouResponseFormat {
    // gzip compression [1, 5] with 5 being the highest compression
    public let gzipCompressionLevel: Int?
    
    // response file format
    public let fileFormat: ResponseFileFormat?
    
    // the columns to select from each row
    public let fields: [ResponseFieldSelection]?
    
    // number of rows to return [1, 500]
    public let limit: Int?
    
    // out of `limit` rows, the starting row from which to return. [1, 2000]
    public let start: Int?
    
    // the order of the return
    public let order: [ResponseOrder?]
}
