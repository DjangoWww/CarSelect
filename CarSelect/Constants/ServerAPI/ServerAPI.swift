//
//  ServerAPI.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import Moya

/// Server API
public enum ServerAPI {
    /// get manufacturer
    case getManufacturer(_ model: ServerManufacturerModelReq)
    /// get main-types
    case getMainTypes(_ model: ServerMainTypesModelReq)
}

// MARK: - TargetType
extension ServerAPI: TargetType {
    public var headers: [String : String]? {
        return nil
    }

    public var baseURL: URL {
        return "http://api-aws-eu-qa-1.auto1-test.com".urlValue!
    }

    public var path: String {
        switch self {
        case .getManufacturer:
            return "v1/car-types/manufacturer"
        case .getMainTypes:
            return "v1/car-types/main-types"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getManufacturer,
                .getMainTypes:
            return .get
        }
    }

    public var sampleData: Data {
        return String.emptyString.data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .getManufacturer(let model):
            var param: [String: Any] = ["wa_key": "coding-puzzle-client-449cc9d"]
            let modelDictValue = model.dictValue() ?? [:]
            _ = modelDictValue.map { param[$0.key] = $0.value }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getMainTypes(let model):
            var param: [String: Any] = ["wa_key": "coding-puzzle-client-449cc9d"]
            let modelDictValue = model.dictValue() ?? [:]
            _ = modelDictValue.map { param[$0.key] = $0.value }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}
