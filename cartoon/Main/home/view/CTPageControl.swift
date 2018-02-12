//
//  CTPageControl.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/8.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTPageControl: UIPageControl {

    override func layoutSubviews() {
        super.layoutSubviews()
        let viewW = bounds.size.width
        let count = subviews.count
        for (index,subView) in subviews.enumerated() {
            subView.frame = CGRect(x: viewW - (subView.frame.size.width + 9) * CGFloat(count - index), y: subView.frame.origin.y + 5, width: subView.frame.size.width, height: subView.frame.size.height)
        }
    }

}
