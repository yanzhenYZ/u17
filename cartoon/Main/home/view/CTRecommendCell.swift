//
//  CTRecommendCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/23.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTRecommendCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    public func configureR(_ comic: CTComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = comic.name
        descLabel.text = comic.short_description
    }
    
    public func configureH(_ comic: CTComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = comic.name
        descLabel.text = comic.subTitle
    }
    
    public func configureN(_ comic: CTComic) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        titleLabel.text = comic.title
        descLabel.text = "更新至 " + comic.content + "集"
    }
    
}
