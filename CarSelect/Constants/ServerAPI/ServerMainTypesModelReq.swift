//
//  ServerMainTypesModelReq.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Foundation

public struct ServerMainTypesModelReq: Codable {
    /// page
    let page: Int
    /// pageSize
    let pageSize: Int
    /// manufacturer
    let manufacturer: String
}
