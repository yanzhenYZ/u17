//
//  CTRHotNewCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/25.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTRHotNewCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var clickNumLabel: UILabel!
    
    public func configure(_ comic: CTComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = comic.name
        descLabel.text = comic.description_new
        clickNumLabel.text = String(comic.clickNum)
    }

}
