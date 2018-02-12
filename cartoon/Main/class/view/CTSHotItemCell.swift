//
//  CTSHotItemCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/2.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTSHotItemCell: UICollectionViewCell {

    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.borderColor = UIColor(displayP3Red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0).cgColor
    }
    
    public func configure(_ hotItem: CTSHotItem) {
        nameLabel.text = hotItem.name
    }

}
