//
//  Moya+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import Moya

extension MoyaError {
    /// MoyaError description
    public var errorMoyaDescription: String {
        switch self {
        case .imageMapping:
            return "imageMapping: \(localizedDescription)"
        case .jsonMapping:
            return "jsonMapping: \(localizedDescription)"
        case .stringMapping:
            return "stringMapping: \(localizedDescription)"
        case .objectMapping( _ , _):
            let string: String
            #if DEVELOP
            var res: String = .emptyString
            print(self, to: &res)
            string = res
            #else
            string = "There's something wrong~"
            #endif
            return string
        case .encodableMapping(let error):
            return "encodableMapping: \(error.errorDescription)"
        case .statusCode(let response):
            return ("statusCode： " + "(\(response.statusCode))")
        case .requestMapping:
            return "requestMapping: \(localizedDescription)"
        case .parameterEncoding(let error):
            return "parameterEncoding: \(error.errorDescription)"
        case .underlying(let error, _):
            return "underlying: \(error.errorDescription)"
        }
    }
}
