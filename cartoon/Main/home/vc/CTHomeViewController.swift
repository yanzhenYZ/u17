//
//  CTHomeViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTHomeViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    private var titleView: CTHTitleView!
    private var childVCs = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //for ios10 tabBar
        edgesForExtendedLayout = []
        titleView = Bundle.main.loadNibNamed("CTHTitleView", owner: nil, options: nil)?.first as! CTHTitleView
        titleView.delegate = self
        navigationItem.titleView = titleView
        
        let childNames = ["cartoon.CTHRecommendViewController", "cartoon.CTHVIPViewController", "cartoon.CTSubscribeViewController", "cartoon.CTRankViewController"]
        for name in childNames {
            let childClass = NSClassFromString(name) as! UIViewController.Type
            let child = childClass.init()
            addChildViewController(child)
            childVCs.append(child)
        }
        let recommend = childVCs[0]
        recommend.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        scrollView.addSubview(recommend.view)
        
        scrollView.contentSize = CGSize(width: WIDTH * 4, height: 0)
    }
}

extension CTHomeViewController: UIScrollViewDelegate {
    //scrollView.setContentOffset will call this method
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / WIDTH)
        titleView.scrollToIndex(index)
        
        let child = childVCs[index]
        if !child.isViewLoaded {
            let width = scrollView.frame.size.width
            child.view.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: scrollView.frame.size.height)
            scrollView.addSubview(child.view)
        }
    }
}

extension CTHomeViewController: CTHTitleViewProtocol {
    func titleViewAction(_ type: CTHTitleBtnType) {
        let offset = CGPoint(x: WIDTH * CGFloat(type.rawValue - 100), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}
