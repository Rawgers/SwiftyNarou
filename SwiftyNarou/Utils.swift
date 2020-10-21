//
//  Utils.swift
//  SwiftyNarou
//
//  Created by Roger Luo on 10/21/20.
//

import Gzip

func gunzip(_ data: Data) -> Data {
    return data.isGzipped
        ? (try? data.gunzipped()) ?? data
        : data
}
