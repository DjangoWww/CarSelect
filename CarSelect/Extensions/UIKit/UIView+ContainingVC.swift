//
//  UIView+ContainingVC.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import UIKit

extension UIView {
    /**
    Returns the UIViewController object that manages the receiver.
    */
    public func viewContainingController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
}
