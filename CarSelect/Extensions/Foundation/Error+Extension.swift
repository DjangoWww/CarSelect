//
//  Error+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import Moya

extension Swift.Error {
    /// Swift.Error description, handles all type of error
    public var errorDescription: String {
        if let moyaError = self as? MoyaError {
            return moyaError.errorMoyaDescription
        } else {
            return localizedDescription
        }
    }
}
