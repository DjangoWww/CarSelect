//
//  Codable+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import Foundation

extension Encodable {
    public func dictValue() -> [String: Any]? {
        if let dict = jsonStringValue()?.dictValue {
            return dict
        } else {
            return nil
        }
    }

    public func jsonStringValue() -> String? {
        let jsonEncoder = JSONEncoder()
        let resString: String?
        do {
            let jsonData = try jsonEncoder.encode(self)
            resString = String(data: jsonData, encoding: .utf8)
        } catch {
            resString = nil
        }
        return resString
    }
}
