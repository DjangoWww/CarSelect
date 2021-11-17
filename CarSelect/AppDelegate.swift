//
//  AppDelegate.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {
}

// MARK: - life cycle
extension AppDelegate {
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.

        // handle all things together
        AppManager.shared.prepare(withOptions: launchOptions)
        return true
    }

    public func applicationDidEnterBackground(
        _ application: UIApplication
    ) {
    }

    public func applicationWillEnterForeground(
        _ application: UIApplication
    ) {
    }

}

// MARK: - open url
extension AppDelegate {
    public func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return true
    }
}

// MARK: - wake up
extension AppDelegate {
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return true
    }
}
