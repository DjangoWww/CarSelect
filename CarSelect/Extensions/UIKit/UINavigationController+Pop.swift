//
//  UINavigationController+Pop.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

// MARK: - pop related
extension UINavigationController {
    public typealias FinishBlock = (_ success: Bool) -> Void

    @discardableResult
    public func popViewController(
        animated: Bool,
        finish block: @escaping FinishBlock
    ) -> UIViewController? {
        defer { block(true) }
        return popViewController(animated: animated)
    }

    @discardableResult
    public func popToRootViewController(
        animated: Bool,
        finish block: @escaping FinishBlock
    ) -> [UIViewController]? {
        defer { block(true) }
        return popToRootViewController(animated: animated)
    }

    @discardableResult
    public func pop(
        to viewController: UIViewController,
        animated: Bool,
        finish block: @escaping FinishBlock
    ) -> [UIViewController]? {
        defer { block(true) }
        return popToViewController(
            viewController,
            animated: animated
        )
    }
}
