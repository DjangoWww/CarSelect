//
//  MainTypesTableViewCell.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

public final class MainTypesTableViewCell: UITableViewCell {
    @IBOutlet private weak var _typeLabel: UILabel!
    public var model: ServerMainTypesModelRes.MainTypeInfoModel? {
        didSet {
            _typeLabel.text = model?.mainTypeValue
        }
    }
    public var isEven: Bool = false {
        didSet {
            backgroundColor = isEven ? .lightGray : .white
        }
    }
}

// MARK: - life cycle
extension MainTypesTableViewCell {
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
