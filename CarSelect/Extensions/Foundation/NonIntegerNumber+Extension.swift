//
//  NonIntegerNumber+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit

extension Float {

    /*
     const
     */
//    public static let zero: Float = 0.0

    /*
     mathematic
     */
    public var half: Float {
        return self / 2.0
    }

    public var double: Float {
        return self * 2.0
    }

    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
    }

    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }

    public var doubleValue: Double {
        return Double(self)
    }

    public var stringValue: String {
        return String(self)
    }

    public var ceilValue: Int {
        return ceil(self).intValue
    }

    public var floorValue: Int {
        return floor(self).intValue
    }

    public var roundValue: Int {
        return roundf(self).intValue
    }

    public var int32Value: Int32 {
        return Int32(self)
    }

    public var absValue: Int32 {
        return abs(int32Value)
    }
}

extension CGFloat {

    /*
     const
     */
//    public static let zero: CGFloat = 0.0

    /*
     mathematic
     */
    public var half: CGFloat {
        return self / 2.0
    }

    public var double: CGFloat {
        return self * 2.0
    }

    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
    }

    public var floatValue: Float {
        return Float(self)
    }

    public var doubleValue: Double {
        return Double(self)
    }

    public var stringValue: String {
        return String(Float(self))
    }

    public var ceilValue: Int {
        return ceil(self).intValue
    }

    public var floorValue: Int {
        return floor(self).intValue
    }

    public var roundValue: Int {
        return roundf(floatValue).intValue
    }

    public var int32Value: Int32 {
        return Int32(self)
    }

    public var absValue: Int32 {
        return abs(int32Value)
    }
}

extension Double {

    /*
     const
     */
//    public static let zero: Double = 0.0

    /*
     mathematic
     */
    public var half: Double {
        return self / 2.0
    }

    public var double: Double {
        return self * 2.0
    }

    /*
     value  conversion
     */
    public var intValue: Int {
        return Int(self)
    }

    public var floatValue: Float {
        return Float(self)
    }

    public var CGFloatValue: CGFloat {
        return CGFloat(self)
    }

    public var stringValue: String {
        return String(self)
    }

    public var ceilValue: Int {
        return ceil(self).intValue
    }

    public var floorValue: Int {
        return floor(self).intValue
    }

    public var roundValue: Int {
        return roundf(floatValue).intValue
    }

    public var int32Value: Int32 {
        return Int32(self)
    }

    public var absValue: Int32 {
        return abs(int32Value)
    }
}
