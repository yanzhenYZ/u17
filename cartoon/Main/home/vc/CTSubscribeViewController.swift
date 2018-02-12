//
//  CTSubscribeViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/14.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTSubscribeViewController: UICollectionViewController {

    private var subscribeLists = [CTComicList]()
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

        collectionView?.backgroundColor = UIColor.white
        collectionView?.u17Header = U17RefreshView(block: { [weak self] in
            self?.getSubscribeData()
        })
        collectionView?.register(UINib.init(nibName: "CTHVIPCell", bundle: nil), forCellWithReuseIdentifier: "CTHVIPCell")
        collectionView?.register(CTRFooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CTRFooterReusableView")
        collectionView?.register(UINib.init(nibName: "CTRHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CTRHeaderReusableView")
        self.getSubscribeData()
        
    }

    private func getSubscribeData() {
        CTHttpTool.get(.Subscribe, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let newSubscribeList = returnData["newSubscribeList"] as! [[String : Any]]
            self.subscribeLists.removeAll()
            for comicDict in newSubscribeList {
                let comicList = CTComicList()
                comicList.setValuesForKeys(comicDict)
                self.subscribeLists.append(comicList)
            }
            self.collectionView?.u17Header?.endRefreshing()
            self.collectionView?.reloadData()
        }) { (error) in
            print("get vip error: \(error.localizedDescription)")
            self.collectionView?.u17Header?.endRefreshing()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CTSubscribeViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subscribeLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let commicList = subscribeLists[section]
        return commicList.comics!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commicList = subscribeLists[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTHVIPCell", for: indexPath) as! CTHVIPCell
        cell.configure(commicList.comics![indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CTRFooterReusableView", for: indexPath)
            return footer
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CTRHeaderReusableView", for: indexPath) as! CTRHeaderReusableView
            header.delegate = self
            header.tag = indexPath.section
            header.configure(subscribeLists[indexPath.section])
            return header
        }
        
    }
}

extension CTSubscribeViewController: CTRHeaderReusableViewProtocol {
    func headerShowMore(_ reusableView: CTRHeaderReusableView) {
        print(reusableView.tag)
    }
    
}
