//
//  CTClassViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTClassViewController: UICollectionViewController {

    private var topLists = [CTCTopModel]()
    private var rankings = [CTCRanking]()
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.footerReferenceSize = CGSize(width: 0, height: 10)
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.placeholder = "端脑"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsetsMake(10, 10, 0, 10)
        collectionView?.register(UINib.init(nibName: "CTCTopCell", bundle: nil), forCellWithReuseIdentifier: "CTCTopCell")
        collectionView?.register(UINib.init(nibName: "CTCRankingCell", bundle: nil), forCellWithReuseIdentifier: "CTCRankingCell")
        
        getCateListData()
    }

    private func getCateListData() {
        CTHttpTool.get(.CateList, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let rankingList = returnData["rankingList"] as! [[String : Any]]
            let topList = returnData["topList"] as! [[String : Any]]
            self.topLists.removeAll()
            self.rankings.removeAll()
            self.topLists.append(contentsOf: topList.map{CTCTopModel($0)})
            self.rankings.append(contentsOf: rankingList.map{CTCRanking($0)})
            self.collectionView?.reloadData()
        }) { (error) in
            print("get cateList error: \(error.localizedDescription)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CTClassViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topLists.count > 3 ? 3 : topLists.count
        }else{
            return rankings.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellW = (collectionView.frame.size.width - 40) / 3
        if indexPath.section == 0 {
            return CGSize(width: cellW, height: 50)
        } else {
            return CGSize(width: cellW, height: 130)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTCTopCell", for: indexPath) as! CTCTopCell
            cell.configure(topLists[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTCRankingCell", for: indexPath) as! CTCRankingCell
            cell.configure(rankings[indexPath.item])
            return cell
        }
    }
}

extension CTClassViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = CTCSearchViewController()
        present(vc, animated: false, completion: nil)
        return false
    }
}
