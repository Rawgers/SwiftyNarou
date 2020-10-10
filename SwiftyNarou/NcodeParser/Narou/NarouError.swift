//
//  NarouError.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/5/20.
//

enum NarouError: Error {
    case ClientError(message: String)
    case ContentError(badData: String)
    case IncorrectNcode(badNcode: String)
    case MalformedUrl(malformedUrl: String)
    case MimetypeError(incorrectMimetype: String)
    case ServerError(errorCode: Int)
}
