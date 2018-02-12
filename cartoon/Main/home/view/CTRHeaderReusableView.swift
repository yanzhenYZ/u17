//
//  CTRHeaderReusableView.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/23.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

protocol CTRHeaderReusableViewProtocol: NSObjectProtocol {
    func headerShowMore(_ reusableView: CTRHeaderReusableView)
}

class CTRHeaderReusableView: UICollectionReusableView {

    public weak var delegate: CTRHeaderReusableViewProtocol?
    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    public func configure(_ comicList: CTComicList) {
        coverImgView.kf.setImage(with: URL(string: comicList.newTitleIconUrl), placeholder: #imageLiteral(resourceName: "normal_placeholder_v"))
        titleLabel.text = comicList.itemTitle
    }
    
    @IBAction private func moreAction(_ sender: UIButton) {
        delegate?.headerShowMore(self)
    }
}
