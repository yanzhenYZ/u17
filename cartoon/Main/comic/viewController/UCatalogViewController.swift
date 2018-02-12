//
//  UCatalogViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/6.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UCatalogViewController: UICollectionViewController {

    public var chapters = [USChapterList]()
    private var startOffsetY: CGFloat = 0
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: (WIDTH - 35) / 2, height: 40)
        layout.headerReferenceSize = CGSize(width: 0, height: 40)
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView?.register(UINib.init(nibName: "UDCatalogCell", bundle: nil), forCellWithReuseIdentifier: "UDCatalogCell")

        // Do any additional setup after loading the view.
    }

    public func setChapters(_ chapters: [USChapterList]) {
        self.chapters.removeAll()
        self.chapters += chapters
    }
    
    public func reloadData() {
        collectionView?.reloadData()
    }

// MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return chapters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UDCatalogCell", for: indexPath) as! UDCatalogCell
        cell.configure(chapters[indexPath.row])
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
