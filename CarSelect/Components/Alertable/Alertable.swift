//
//  Alertable.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import UIKit

// MARK: - AlertAble
public protocol AlertAble {
    /// notice all handler is escaping
    typealias HandlerType = (UIAlertAction) -> Void
    /// notice all handler is escaping
    typealias AlertActionType = (title: String?,
                                 style: UIAlertAction.Style,
                                 handler: (HandlerType)?)
    /// notice all handler is escaping
    func showAlertVcWith(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: [AlertActionType]
    )
}

extension AlertAble {
    /// notice all handler is escaping
    public func showAlertVcWith(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: [AlertActionType]
    ) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle
            )
            _ = actions
                .map { UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler) }
                .map(alertVC.addAction)
            AppManager.shared.windowManager.rootVcForCurrentWindow()?.present(alertVC, animated: true, completion: nil)
        }
    }
}

extension AlertAble where Self: UIViewController {
    /// notice all handler is escaping
    public func showAlertVcWith(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: [AlertActionType]
    ) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle
            )
            _ = actions
                .map { UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler) }
                .map(alertVC.addAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
extension AlertAble where Self: UIView {
    /// notice all handler is escaping
    public func showAlertVcWith(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: [AlertActionType]
    ) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle
            )
            _ = actions
                .map { UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler) }
                .map(alertVC.addAction)
            self.viewContainingController()?.present(alertVC, animated: true, completion: nil)
        }
    }
}
