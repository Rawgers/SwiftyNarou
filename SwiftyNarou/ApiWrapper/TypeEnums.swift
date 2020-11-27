//
//  TypeEnums.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/13/20.
//

public enum Genre: Int, CaseIterable {
    case romance = 1
    case fantasy = 2
    case literature = 3
    case scifi = 4
    case other = 99
    case none = 98
    
    var nameJP: String {
        switch self {
        case .romance: return "恋愛"
        case .fantasy: return "ファンタジー"
        case .literature: return "文芸"
        case .scifi: return "SF"
        case .other: return "その他"
        case .none: return "ノンジャンル"
        }
    }
    
//    var nameEN: String {
//        switch self {
//        case .romance: return "Romance"
//        case .fantasy: return "Fantasy"
//        case .literature: return "Literature"
//        case .scifi: return "Sci-fi"
//        case .other: return "Other"
//        case .none: return "No Genre"
//        }
//    }
}

public enum Subgenre: Int, CaseIterable {
    case romanceIsekai = 101
    case romanceReality = 102
    case fantasyHigh = 201
    case fantasyLow = 202
    case literaturePure = 301
    case literatureDrama = 302
    case literatureHistory = 303
    case literatureMystery = 304
    case literatureHorror = 305
    case literatureAction = 306
    case literatureComedy = 307
    case scifiVr = 401
    case scifiSpace = 402
    case scifiFantasy = 403
    case scifiThriller = 404
    case miscFairyTale = 9901
    case miscPoem = 9902
    case miscEssay = 9903
    case miscReplay = 9904
    case miscOther = 9999
    case none = 9801
    
    var nameJP: String {
        switch self {
        case .romanceIsekai: return "異世界〔恋愛〕"
        case .romanceReality: return "現実世界〔恋愛〕"
        case .fantasyHigh: return "ハイファンタジー〔ファンタジー〕"
        case .fantasyLow: return "ローファンタジー〔ファンタジー〕"
        case .literaturePure: return "純文学〔文芸〕"
        case .literatureDrama: return "ヒューマンドラマ〔文芸〕"
        case .literatureHistory: return "歴史〔文芸〕"
        case .literatureMystery: return "推理〔文芸〕"
        case .literatureHorror: return "ホラー〔文芸〕"
        case .literatureAction: return "アクション〔文芸〕"
        case .literatureComedy: return "コメディー〔文芸〕"
        case .scifiVr: return "VRゲーム〔SF〕"
        case .scifiSpace: return "宇宙〔SF〕"
        case .scifiFantasy: return "空想科学〔SF〕"
        case .scifiThriller: return "パニック〔SF〕"
        case .miscFairyTale: return "童話〔その他〕"
        case .miscPoem: return "詩〔その他〕"
        case .miscEssay: return "エッセイ〔その他〕"
        case .miscReplay: return "リプレイ〔その他〕"
        case .miscOther: return "その他〔その他〕"
        case .none: return "ノンジャンル〔ノンジャンル〕"
        }
    }
    
//    var nameEN: String {
//        switch self {
//        case .romanceIsekai: return "Fantasy Romance"
//        case .romanceReality: return "Non-fantasy Romance"
//        case .fantasyHigh: return "High Fantasy"
//        case .fantasyLow: return "Low Fantasy"
//        case .literaturePure: return "Pure Literature"
//        case .literatureDrama: return "Human Drama"
//        case .literatureHistory: return "History"
//        case .literatureMystery: return "Mystery"
//        case .literatureHorror: return "Horror"
//        case .literatureAction: return "Action"
//        case .literatureComedy: return "Comedy"
//        case .scifiVr: return "Sci-fi (VR)"
//        case .scifiSpace: return "Sci-fi (Space)"
//        case .scifiFantasy: return "Sci-fi (Fantasy)"
//        case .scifiThriller: return "Sci-fi (Thriller)"
//        case .miscFairyTale: return "Fairy Tale"
//        case .miscPoem: return "Poem"
//        case .miscEssay: return "Essay"
//        case .miscReplay: return "Replay"
//        case .miscOther: return "Other"
//        case .none: return "No Genre"
//        }
//    }
}

public enum NovelType: Int {
    case series = 1
    case shortStory = 2
}

public enum PcOrK: Int {
    case mobile = 1
    case pc = 2
    case both = 3
}
