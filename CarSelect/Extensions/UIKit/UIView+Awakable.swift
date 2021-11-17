//
//  UIView+Awakable.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit

// MARK: - Xib extension
public protocol ViewAwakable { }
extension UIView: ViewAwakable { }

extension ViewAwakable where Self: UIView {
    /// using xibName to create xib
    public static func createFromXib(
        nibName: String? = nil
    ) -> Self? {
        let result: Self?
        let className = nibName ?? NSStringFromClass(self).components(separatedBy: ".").last
        if let className = className {
            result = UINib(nibName: className, bundle: Bundle.main)
                .instantiate(withOwner: nil, options: nil)[safe: 0] as? Self
        } else {
            result = nil
        }
        return result
    }
}
