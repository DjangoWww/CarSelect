//
//  Bundle+Extension.swift
//  CarSelect
//
//  Created by Django on 2021/11/15.
//

import Foundation

extension Bundle {
    /// change bundle
    public func onLanguageChange() {
        Bundle._onLanguageDispatchOnce()
    }

    private static var _onLanguageDispatchOnce: () -> Void = {
        // replace Bundle.main by BundleEx
        object_setClass(Bundle.main, _BundleEx.self)
    }

    fileprivate class func _getLanguageBundel() -> Bundle? {
        let language = "en" // AppManager.shared.languageManager.getCurrentLanguage().getBundleName()
        guard let languageBundlePath = Bundle.main.path(forResource: language, ofType: "lproj"),
              let languageBundle = Bundle(path: languageBundlePath) else {
            return nil
        }
        return languageBundle
    }
}

fileprivate final class _BundleEx: Bundle {
    override func localizedString(
        forKey key: String,
        value: String?,
        table tableName: String?
    ) -> String {
        if let bundle = Bundle._getLanguageBundel() {
            return bundle.localizedString(
                forKey: key,
                value: value,
                table: tableName
            )
        } else {
            return super.localizedString(
                forKey: key,
                value: value,
                table: tableName
            )
        }
    }
}
