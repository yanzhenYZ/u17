//
//  CTNavigationViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "nav_bg"), for: .default)
    }

}
