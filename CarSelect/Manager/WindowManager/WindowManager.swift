//
//  WindowManager.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import UIKit

/// Window manager
public final class WindowManager {
    
    public enum WindowType: Int, CaseIterable {
        case mainWindow
    }

    public static let shared = WindowManager()

    /// current window
    private weak var _currentWindow: UIWindow?
    /// all windows stoerd inside
    private var _windowsContainerArr: [UIWindow] = []
}

// MARK: - public funcs
extension WindowManager {
    /// show mainWindow
    public func showMainWindow() {
        let mainWindow = MainWindow()
        _storeAvailableWindow(for: mainWindow)
        _makeKeyAndVisible(for: mainWindow)
    }

    /// get rootVc for current window
    public func rootVcForCurrentWindow() -> UIViewController? {
        return _currentWindow?.rootViewController
    }
}

// MARK: - private func
extension WindowManager {
    /// storeAvailableWindow
    private func _storeAvailableWindow(for window: UIWindow) {
        if _windowsContainerArr.contains(window) {
            return
        } else {
            _windowsContainerArr.append(window)
        }
    }

    /// makeKeyAndVisible for window
    private func _makeKeyAndVisible(for window: UIWindow) {
        window.makeKeyAndVisible()
        _currentWindow = window
    }
}
