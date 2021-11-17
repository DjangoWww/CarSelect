//
//  ManufacturerTableViewCell.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

public final class ManufacturerTableViewCell: UITableViewCell {
    @IBOutlet private weak var _nameLabel: UILabel!
    @IBOutlet private weak var _idLabel: UILabel!
    public var model: ServerManufacturerModelRes.ManufacturerInfoModel? {
        didSet {
            _nameLabel.text = model?.manufacturerName
            _idLabel.text = model?.manufacturerID
        }
    }
    public var isEven: Bool = false {
        didSet {
            backgroundColor = isEven ? .lightGray : .white
        }
    }
}

// MARK: - life cycle
extension ManufacturerTableViewCell {
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
