//
//  CTHTitleView.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/29.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

protocol CTHTitleViewProtocol: NSObjectProtocol {
    func titleViewAction(_ type: CTHTitleBtnType)
}

enum CTHTitleBtnType: Int {
    case Recommend = 100
    case VIP
    case Subscribe
    case Ranking
}

class CTHTitleView: UIView {

    public weak var delegate: CTHTitleViewProtocol?
    private weak var selectedBtn: UIButton!
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: WIDTH - 100, height: 44)
        }
    }

    public func scrollToIndex(_ index: Int) {
        let btn = viewWithTag(index + 100) as! UIButton
        
        selectedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        selectedBtn.alpha = 0.6
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.alpha = 1
        selectedBtn = btn
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBtn = viewWithTag(100) as! UIButton
    }
    
    @IBAction func btnsAction(_ sender: UIButton) {
        if sender == selectedBtn { return }
        delegate?.titleViewAction(CTHTitleBtnType(rawValue: sender.tag)!)
    }
    
}
