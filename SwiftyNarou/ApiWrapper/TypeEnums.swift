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
    public enum Romance: Int {
        case isekai = 101
        case reality = 102
    }
    
    public enum Fantasy: Int {
        case high = 201
        case low = 202
    }
    
    public enum Literature: Int {
        case pure = 301
        case drama = 302
        case history = 303
        case mystery = 304
        case horror = 305
        case action = 306
        case comedy = 307
    }
    
    public enum Scifi: Int {
        case vr = 401
        case space = 402
        case fantasy = 403
        case panic = 404
    }
    
    public enum Other: Int {
        case fairyTale = 9901
        case poem = 9902
        case essay = 9903
        case misc = 9999
    }
    
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
