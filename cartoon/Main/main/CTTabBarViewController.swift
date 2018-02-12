//
//  CTTabBarViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = CTHomeViewController()
        let homeNVC = CTNavigationViewController(rootViewController: homeVC)
        
        let classVC = CTClassViewController()
        let classNVC = CTNavigationViewController(rootViewController: classVC)
        
        let mineVC = CTMineViewController()
        let mineNVC = CTNavigationViewController(rootViewController: mineVC)
        viewControllers = [homeNVC, classNVC, mineNVC]
        
        let tab = CTTabBar(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 49))
        tab.delegate = self
        tabBar.addSubview(tab)
        
    }
}

extension CTTabBarViewController: CTTabBarDelegate {
    func ctTabBarBtnClick(_ idx: Int) {
        selectedIndex = idx
    }
}
