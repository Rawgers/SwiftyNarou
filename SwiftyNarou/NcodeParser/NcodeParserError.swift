//
//  Errors.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/4/20.
//

enum NcodeParserError: Error {
    case IncorrectNcode(badNcode: String)
    case MalformedUrl(malformedUrl: String)
    case ClientError(message: String)
    case ServerError(errorCode: Int)
    case MimetypeError(incorrectMimetype: String)
    case ContentsError(badData: String)
}
