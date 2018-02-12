//
//  CTCTopCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/5.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTCTopCell: UICollectionViewCell {

    @IBOutlet private weak var coverImgView: UIImageView!
    public func configure(_ topModel: CTCTopModel) {
        coverImgView.kf.setImage(with: URL(string: topModel.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
    }
    

}
