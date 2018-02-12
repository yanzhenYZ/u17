//
//  UDLikeCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/12.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDLikeCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    public func configure(_ comic: UGuessComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_v"))
        nameLabel.text = comic.name
    }

}
