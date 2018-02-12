//
//  CTHVIPCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/29.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTHVIPCell: UICollectionViewCell {

    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    public func configure(_ comic: CTComic) {
        coverImageView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = comic.name
    }


}
