//
//  ServerManufacturerModelReq.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Foundation

public struct ServerManufacturerModelReq: Codable {
    /// page
    let page: Int
    /// pageSize
    let pageSize: Int
}
