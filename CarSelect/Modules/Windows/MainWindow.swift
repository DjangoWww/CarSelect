//
//  MainWindow.swift
//  CarSelect
//
//  Created by Django on 2021/11/16.
//

import UIKit

/// Main window
public final class MainWindow: UIWindow {

    public override init(
        frame: CGRect = UIScreen.main.bounds
    ) {
        super.init(frame: frame)
        let rootVC = UINavigationController(rootViewController: ManufacturerVC())
        rootViewController = rootVC
    }

    required init?(coder: NSCoder) {
        fatalError("it's not implemented for xib")
    }
}
