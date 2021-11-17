//
//  ServerModelTypeRes.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Foundation

public protocol ServerModelTypeRes: Codable { }
extension Optional: ServerModelTypeRes where Wrapped: ServerModelTypeRes { }
