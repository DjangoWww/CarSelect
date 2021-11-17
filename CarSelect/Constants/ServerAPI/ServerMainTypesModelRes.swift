//
//  ServerMainTypesModelRes.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Foundation

public struct ServerMainTypesModelRes: ServerModelTypeRes {
    let page: Int
    let pageSize: Int
    let totalPageCount: Int
    let mainTypesInfo: MainTypesInfoContainerModel

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case mainTypesInfo = "wkda"
    }
}

extension ServerMainTypesModelRes {
    public struct MainTypesInfoContainerModel: Codable {
        let models: [MainTypeInfoModel]
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer().decode([String: String].self)
            models = container.map(MainTypeInfoModel.init)
        }
    }
}

extension ServerMainTypesModelRes {
    public struct MainTypeInfoModel: Codable {
        let mainTypeKey: String
        let mainTypeValue: String
    }
}

/*
 {"page":0,"pageSize":10,"totalPageCount":1,"wkda":{"DB 5":"DB 5","DB 7":"DB 7","DB 9":"DB 9","DB 10":"DB 10","DBS":"DBS","Rapide":"Rapide","V8":"V8","V8 Vantage":"V8 Vantage","Vanquish":"Vanquish"}}
 */
