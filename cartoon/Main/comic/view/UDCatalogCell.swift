//
//  UDCatalogCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/12.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDCatalogCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var chapter_new: UIImageView!
    @IBOutlet private weak var chapter_vip: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.borderColor = UIColor.gray.cgColor
    }
    
    public func configure(_ chapter: USChapterList) {
        nameLabel.text = chapter.name
        chapter_new.isHidden = chapter.is_new == 0
        chapter_vip.isHidden = Double(chapter.price) == 0
    }

}
