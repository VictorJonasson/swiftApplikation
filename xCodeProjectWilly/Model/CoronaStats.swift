//
//  Country.swift
//  xCodeProjectWilly
//
//  Created by Victor on 2021-04-11.
//

import Foundation

struct Response: Codable {
    let All: MyResult
}

struct MyResult: Codable {
    let administered: Int
}
