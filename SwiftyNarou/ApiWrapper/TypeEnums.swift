//
//  TypeEnums.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/13/20.
//

public enum BigGenre: Int {
    case romance = 1
    case fantasy = 2
    case literature = 3
    case scifi = 4
    case other = 99
    case none = 98
}

public enum Genre: Int {
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
    case scifiPanic = 404
    case miscFairyTale = 9901
    case miscPoem = 9902
    case miscEssay = 9903
    case miscOther = 9999
    case none = 9801
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
