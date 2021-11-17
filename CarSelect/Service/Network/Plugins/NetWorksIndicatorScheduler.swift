//
//  NetWorksIndicatorScheduler.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

/// NetWorksIndicatorScheduler
public final class NetWorksIndicatorScheduler {
    private init() { }
    public static let shared = NetWorksIndicatorScheduler()

    private let _lock = NSRecursiveLock()
    private var _activityCount: Int = 0

    public func pushActivityIndicator() {
        _lock.lock()
        _activityCount += 1
        let count = _activityCount
        _lock.unlock()
        _updateActivityIndicator(with: count)
    }

    public func popActivityIndicator() {
        _lock.lock()
        _activityCount -= 1
        if _activityCount < 0 { _activityCount = 0 }
        let count = _activityCount
        _lock.unlock()
        _updateActivityIndicator(with: count)
    }

    private func _updateActivityIndicator(with count: Int) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = count > 0
        }
    }
}
