//
//  UIView+Frame.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit

// MARK: - UIView + Frame extension
extension UIView {
    /// X point
    public var x: CGFloat {
        get { return frame.origin.x }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }

    /// Y point
    public var y: CGFloat {
        get { return frame.origin.y }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    public var size: CGSize {
        get { return bounds.size }
        set { bounds.size = newValue }
    }

    public var width: CGFloat {
        get { return frame.size.width }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }

    public var halfWidth: CGFloat {
        return width.half
    }

    public var height: CGFloat {
        get { return frame.size.height }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }

    public var halfHeight: CGFloat {
        return height.half
    }

    public var centerX: CGFloat {
        get { return center.x }
        set {
            var newCenter = center
            newCenter.x = newValue
            center = newCenter
        }
    }

    public var centerY : CGFloat {
        get { return center.y }
        set {
            var newCenter = center
            newCenter.y = newValue
            center = newCenter
        }
    }
}
