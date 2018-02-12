//
//  UCatalogViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/6.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class UCatalogViewController: UICollectionViewController {

    private var startOffsetY: CGFloat = 0
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (WIDTH - 10) / 3, height: 190)
        layout.headerReferenceSize = CGSize(width: 0, height: 40)
        layout.footerReferenceSize = CGSize(width: 0, height: 10)
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }


// MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UCatalogViewController {
    private weak var parentVC: UComicViewController! {
        get {
            return parent as! UComicViewController
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetY = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //not 0
        if scrollView.contentOffset.y < 0 {
            //can't < 0
            parentVC.subScrollViewDidScroll(false, start: false)
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
        }else if scrollView.contentOffset.y > 0 {
            if !parentVC.subScrollViewDidScroll(true, start: startOffsetY == 0) && startOffsetY == 0 {
                scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
            }
        }
    }
}
