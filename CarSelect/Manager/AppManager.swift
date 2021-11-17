//
//  AppManager.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import UIKit

/// Manager all the managers in this app
public final class AppManager: NSObject {
    private override init() { }
    public static let shared = AppManager()

    /// Window manager
    public var windowManager: WindowManager {
        return WindowManager.shared
    }

    /// Toast manager
    public var toastManager: ToastManager {
        return ToastManager.shared
    }

    public func prepare(
        withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        // setup for some UI related
        let toastDuration: Double
        #if DEBUG
        toastDuration = 10
        #else
        toastDuration = 3
        #endif
        AppManager.shared.toastManager.duration = toastDuration

        // reset language
        Bundle.main.onLanguageChange()

        // show main window
        AppManager.shared.windowManager.showMainWindow()
    }
}
