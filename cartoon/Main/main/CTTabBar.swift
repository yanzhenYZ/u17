//
//  CTTabBar.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

protocol CTTabBarDelegate: NSObjectProtocol {
    func ctTabBarBtnClick(_ idx: Int)
}

class CTTabBar: UIView {

    weak var delegate: CTTabBarDelegate?
    private var selectedBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let btnW = WIDTH / 3
        
        let block = { (tag: Int, imgName: String) -> UIButton in
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.white
            btn.tag = tag
            btn.adjustsImageWhenHighlighted = false
            btn.frame = CGRect(x: btnW * CGFloat(tag), y: 0, width: btnW, height: 49)
            btn.setImage(UIImage(named: imgName), for: .normal)
            btn.setImage(UIImage(named: imgName + "_S"), for: .selected)
            btn.addTarget(self, action: #selector(self.bottomBtnAction(_:)), for: .touchUpInside)
            return btn
        }
        let homeBtn = block(0, "tab_home")
        homeBtn.isSelected = true
        selectedBtn = homeBtn
        addSubview(homeBtn)
        addSubview(block(1, "tab_class"))
        addSubview(block(2, "tab_mine"))
    }
    
    @objc private func bottomBtnAction(_ btn: UIButton) {
        if btn.isSelected { return }
        selectedBtn.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
        delegate?.ctTabBarBtnClick(btn.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
