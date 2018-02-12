//
//  CTRFooterReusableView.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTRFooterReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(displayP3Red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
