//
//  ServerManufacturerModelRes.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Foundation

public struct ServerManufacturerModelRes: ServerModelTypeRes {
    let page: Int
    let pageSize: Int
    let totalPageCount: Int
    let manufacturerInfo: ManufacturerInfoContainerModel

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case manufacturerInfo = "wkda"
    }
}

extension ServerManufacturerModelRes {
    public struct ManufacturerInfoContainerModel: Codable {
        let models: [ManufacturerInfoModel]
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer().decode([String: String].self)
            models = container.map(ManufacturerInfoModel.init)
        }
    }
}

extension ServerManufacturerModelRes {
    public struct ManufacturerInfoModel: Codable {
        let manufacturerID: String
        let manufacturerName: String
    }
}

/*
 {"page":0,"pageSize":50,"totalPageCount":2,"wkda":{"020":"Abarth","040":"Alfa Romeo","042":"Alpina","043":"Alpine","057":"Aston Martin","060":"Audi","095":"Barkas","107":"Bentley","130":"BMW","125":"Borgward","145":"Brilliance","141":"Buick","150":"Cadillac","157":"Caterham","160":"Chevrolet","170":"Chrysler","190":"Citroen","191":"Corvette","189":"Cupra","194":"Dacia","195":"Daewoo","210":"Daihatsu","230":"Dodge","235":"DS Automobiles","250":"e.GO","277":"Ferrari","280":"Fiat","285":"Ford","340":"Honda","345":"Hyundai","357":"Infiniti","362":"Isuzu","365":"Iveco","380":"Jaguar","390":"Jeep","425":"Kia","460":"Lada","465":"Lamborghini","470":"Lancia","730":"Land Rover","487":"Lexus","502":"Lotus","520":"MAN","522":"Maserati","550":"Mazda","570":"Mercedes-Benz","070":"MG Rover","580":"MINI","590":"Mitsubishi","225":"Nissan"}}
 */
