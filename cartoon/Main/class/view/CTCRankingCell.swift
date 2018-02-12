//
//  CTCRankingCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/5.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTCRankingCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
        backView.layer.borderWidth = 0.2
        backView.layer.borderColor = UIColor.gray.cgColor
    }

    public func configure(_ ranking: CTCRanking) {
        coverImgView.kf.setImage(with: URL(string: ranking.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = ranking.sortName
        
    }
}
