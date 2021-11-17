//
//  UIView+Rotate.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit

// MARK: - UIView + Rotation extensions
extension UIView {
    public func startRotate(
        duration: CFTimeInterval = 0.6,
        isCumulative: Bool = true,
        repeatCount: Float = MAXFLOAT
    ) {
        if let _ = layer.animation(forKey: .rotateAnimationKey) {
            return
        }
        let animate = CABasicAnimation(keyPath: .rotationKeyZ)
        animate.toValue = NSNumber(value: Double.pi.double)
        animate.duration = duration
        animate.isCumulative = isCumulative
        animate.repeatCount  = repeatCount
        layer.add(animate, forKey: .rotateAnimationKey)
    }

    public func stopRotate() {
        layer.removeAnimation(forKey: .rotateAnimationKey)
    }
    
    public func shakeAnimation(
        duration: CFTimeInterval = 0.05,
        xValue: Int = 5,
        repeatCount: Float = 4,
        autoreverses: Bool = true
    ) {
        if let _ = layer.animation(forKey: .shakeAnimationKey) {
            return
        }
        let shakeAnimation = CABasicAnimation(keyPath: .translationX)
        shakeAnimation.fromValue = NSNumber(value: -xValue)
        shakeAnimation.toValue = NSNumber(value: xValue)
        shakeAnimation.duration = duration
        shakeAnimation.repeatCount = repeatCount
        shakeAnimation.autoreverses = autoreverses
        layer.add(shakeAnimation, forKey: .shakeAnimationKey)
    }
}

// MARK: - UIView + Extension related String extension
extension String {
    fileprivate static let rotationKeyZ = "transform.rotation.z"
    fileprivate static let rotateAnimationKey = "rotationAnimate"

    fileprivate static let translationX = "transform.translation.x"
    fileprivate static let shakeAnimationKey = "shakeAnimation"
}
