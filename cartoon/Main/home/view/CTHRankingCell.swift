//
//  CTHRankingCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/30.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTHRankingCell: UITableViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    public func configure(_ rank: CTHRankList) {
        coverImgView.kf.setImage(with: URL(string: rank.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = rank.title + "榜"
        subTitleLabel.text = rank.subTitle
    }
    
}
