//
//  CTCycleCell.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/14.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit
import Kingfisher

class CTCycleCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    public func configure(_ gallery: CTGallery) {
        coverImgView.kf.setImage(with: URL(string: gallery.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
    }

}
