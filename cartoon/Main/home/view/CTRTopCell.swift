//
//  CTRTopCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit
import Kingfisher

class CTRTopCell: UICollectionViewCell {

    @IBOutlet private weak var iconImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    public func configure(_ comic: CTComic) {
        titleLabel.text = comic.name
        iconImgView.kf.setImage(with: URL(string: comic.cover), placeholder: nil)
    }

}
