//
//  String+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit
import CommonCrypto

extension Character {

    /*
     value conversion
     */
    public var stringValue: String {
        return String(self)
    }
}

extension String.SubSequence {
    /*
     value conversion
     */
    public var stringValue: String {
        return String(self)
    }
}

extension String {

    /*
     const
     */
    public static let emptyString: String = ""
    public static let spaceString: String = " "

    /*
     value conversion
     */
    public var intValue: Int? {
        return Int(self)
    }

    public var floatValue: Float? {
        return Float(self)
    }

    public var CGFloatValue: CGFloat? {
        return floatValue.map { CGFloat($0) }
    }

    public var doubleValue: Double? {
        return Double(self)
    }

    public var urlValue: URL? {
        return URL(string: self)
    }

    public var boolValue: Bool? {
        let resString = lowercased().filter()
        if resString == "true" {
            return true
        } else if resString == "false" {
            return false
        }
        return nil
    }

    public var utf8Value: String? {
        var arr = [UInt8]()
        arr += utf8
        return String(bytes: arr, encoding: .utf8)
    }

    public var dictValue: [String: Any]? {
        return self
            .data(using: .utf8)
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .mutableContainers) as? [String: Any] }
    }
}

// MARK: - manipulate funcs
extension String {
    /// separate string by maxLength
    public func components(
        separatedBy maxLength: Int
    ) -> [String] {
        var resArr: [String] = []
        var baseString = self
        var prefixString: String
        repeat {
            prefixString = baseString.prefix(maxLength).stringValue
            resArr.append(prefixString)
            baseString = baseString.replacingOccurrenceOnce(
                of: prefixString,
                with: String.emptyString,
                option: .forwards
            )
        } while baseString.count > 0
        return resArr
    }

    /// filter spaces and new line
    public func filter(
        _ set: CharacterSet = .whitespacesAndNewlines,
        by separator: String = .emptyString
    ) -> String {
        return components(separatedBy: set)
            .joined(separator: separator)
    }

    /// judge if a string contains another using optional chain
    public func isContains(
        _ string: String
    ) -> String? {
        return contains(string) ? self : nil
    }

    /// judge if a string is empty using optional chain
    public func checkEmpty(
        isfilter: Bool = true
    ) -> String? {
        if isfilter {
            let filtedString = filter()
            return filtedString.count > 0 ? filtedString : nil
        }
        return count > 0 ? self : nil
    }

    /// transform to Pinyin
    public func transformToPinyin() -> String? {
        return self
            .applyingTransform(.toLatin, reverse: false)?
            .applyingTransform(.stripCombiningMarks, reverse: false)
    }

    /// transform to Pinyin header
    public func transformToPinyinHeader() -> String? {
        let pinyin = transformToPinyin()
        let pinyinCompare = pinyin?.capitalized
        var headPinyinStr = String.emptyString
        let _ = pinyinCompare?.map { if $0 <= "Z" && $0 >= "A" { headPinyinStr.append($0) } }
        return headPinyinStr.checkEmpty()
    }

    /// check if a string is valid mobile using optional chain
    public func isValidMobile() -> String? {
        return isValidMobile() ? self : nil
    }

    public func isValidMobile() -> Bool {
        let regex = "^1\\d{10}$"
        let predicate: NSPredicate = NSPredicate(
            format: "SELF MATCHES %@", regex
        )
        return predicate.evaluate(with: self)
    }

    /// check if a string is valid email address using optional chain
    public func isValidEmail() -> String? {
        return isValidEmail() ? self : nil
    }

    public func isValidEmail() -> Bool {
        let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate: NSPredicate = NSPredicate(
            format: "SELF MATCHES %@", regex
        )
        return predicate.evaluate(with: self)
    }

    /// check if a string is valid money amount using optional chain
    public func isValidMoney() -> String? {
        return isValidMoney() ? self : nil
    }

    public func isValidMoney() -> Bool {
        let regex = "^([1-9]\\d{0,20}|0)([.]?|(\\.\\d{1,2})?)$"
        let predicate: NSPredicate = NSPredicate(
            format: "SELF MATCHES %@", regex
        )
        return predicate.evaluate(with: self)
    }

    /// filter all numbers within a string
    public func filterNumber() -> String {
        return filter().filter(CharacterSet.decimalDigits.inverted)
    }

    /// filter all numbers and letters within a string
    public func filterNumberAndLetter() -> String {
        let temp = CharacterSet(
            charactersIn: "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLMNBVCXZ1234567890"
        )
        return filter().filter(temp.inverted)
    }
}

extension String {
    public enum ReplacingOptions {
        /// forwards
        case forwards
        /// backwards
        case backwards
    }

    /// replacingOccurrenceOnce
    public func replacingOccurrenceOnce<Target, Replacement>(
        of target: Target,
        with replacement: Replacement,
        option: ReplacingOptions,
        range searchRange: Range<Self.Index>? = nil,
        caseInsensitive: Bool = true
    ) -> String where Target : StringProtocol, Replacement : StringProtocol {
        let option1: String.CompareOptions
        switch option {
        case .backwards: option1 = .backwards
        case .forwards: option1 = .anchored
        }
        let options: String.CompareOptions
        if caseInsensitive { options = [option1, .caseInsensitive] }
        else { options = [option1] }
        if let range = range(
            of: target,
            options: options,
            range: searchRange,
            locale: nil
        ) {
            return replacingCharacters(
                in: range,
                with: replacement
            )
        } else { return self }
    }
}
