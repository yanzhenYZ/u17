//
//  UDDescriptionCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/8.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDDescriptionCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    public func setDescription(_ desc: String?) {
        descriptionLabel.text = desc
    }
    
}
