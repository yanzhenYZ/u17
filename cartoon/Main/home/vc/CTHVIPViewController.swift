//
//  CTHVIPViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTHVIPViewController: UICollectionViewController {

    
    private var vipLists = [CTComicList]()
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

        //http://app.u17.com/v3/appV3_3/ios/phone/list/vipList?device_id=7D495599-CE39-4900-BD9F-8D95619A46E2&key=fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986%3A%3A%3Aopen&model=iPhone%205s&target=U17_3.0&time=1516691278&version=3.3.3
        collectionView?.backgroundColor = UIColor.white
        collectionView?.u17Header = U17RefreshView(block: { [weak self] in
            self?.getVIPData()
        })
        collectionView?.register(UINib.init(nibName: "CTHVIPCell", bundle: nil), forCellWithReuseIdentifier: "CTHVIPCell")
        collectionView?.register(CTRFooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CTRFooterReusableView")
        collectionView?.register(UINib.init(nibName: "CTRHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CTRHeaderReusableView")
        self.getVIPData()
    }
    
    private func getVIPData() {
        CTHttpTool.get(.VIP, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let newVipList = returnData["newVipList"] as! [[String : Any]]
            self.vipLists.removeAll()
            for comicDict in newVipList {
                let comicList = CTComicList()
                comicList.setValuesForKeys(comicDict)
                self.vipLists.append(comicList)
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

extension CTHVIPViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vipLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let commicList = vipLists[section]
        return commicList.comics!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commicList = vipLists[indexPath.section]
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
            header.configure(vipLists[indexPath.section])
            return header
        }
    }
}

extension CTHVIPViewController: CTRHeaderReusableViewProtocol {
    func headerShowMore(_ reusableView: CTRHeaderReusableView) {
        print(reusableView.tag)
    }
    
}
