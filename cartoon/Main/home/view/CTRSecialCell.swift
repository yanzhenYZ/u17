//
//  CTRSecialCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/24.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTRSecialCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    public func configure(_ comic: CTComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
    }

}
