//
//  CTHRecommendViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTHRecommendViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var cycleView: CTCycleView!
    @IBOutlet private weak var cycleViewTopLayout: NSLayoutConstraint!
    private var commicLists = [CTComicList]()
    override func viewDidLoad() {
        super.viewDidLoad()

        cycleView.delegate = self
        
        let screenW = WIDTH
        collectionView.u17Header = U17RefreshView(block: { [weak self] in
            self?.getRecommendData()
        })
        collectionView.collectionViewLayout = CTCollectionViewFlowLayout()
        var contentInset = collectionView.contentInset
        contentInset.top += screenW / 2
        collectionView.contentInset = contentInset
        collectionView.register(UINib.init(nibName: "CTRTopCell", bundle: nil), forCellWithReuseIdentifier: "CTRTopCell")
        collectionView.register(UINib.init(nibName: "CTRecommendCell", bundle: nil), forCellWithReuseIdentifier: "CTRecommendCell")
        collectionView.register(UINib.init(nibName: "CTRSecialCell", bundle: nil), forCellWithReuseIdentifier: "CTRSecialCell")
        collectionView.register(UINib.init(nibName: "CTRHotNewCell", bundle: nil), forCellWithReuseIdentifier: "CTRHotNewCell")
        //
        collectionView.register(CTRFooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CTRFooterReusableView")
        collectionView.register(UINib.init(nibName: "CTRHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CTRHeaderReusableView")
        
        getRecommendData()
        //http://app.u17.com/v3/appV3_3/ios/phone/comic/boutiqueListNew?device_id=7D495599-CE39-4900-BD9F-8D95619A46E2&key=fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986%3A%3A%3Aopen&model=iPhone%205s&sexType=1&target=U17_3.0&time=1516691278&v=3320101&version=3.3.3
    }
    
    private func getRecommendData() {
        CTHttpTool.get(.Recommend, success: { [weak self] (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let galleryItems = returnData["galleryItems"] as! [[String : Any]]
            self?.cycleView.getAllData(galleryItems)
            let comicLists_1 = returnData["comicLists"] as! [[String : Any]]
            self?.commicLists.removeAll()
            for comicDict in comicLists_1 {
                let comicList = CTComicList()
                comicList.setValuesForKeys(comicDict)
                self?.commicLists.append(comicList)
            }
            self?.collectionView.u17Header?.endRefreshing()
            self?.collectionView.reloadData()
        }) { (error) in
            print(error)
            self.collectionView.u17Header?.endRefreshing()
        }
    }

}

extension CTHRecommendViewController: UICollectionViewDataSource, CTCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return commicLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let commicList = commicLists[section]
        if commicList.comicType == CTComicType.Top.rawValue {
            return 4
        }else if commicList.comicType == CTComicType.Recommend.rawValue {
            return commicList.comics!.count > 4 ? 4 : commicList.comics!.count
        }else if commicList.comicType == CTComicType.Hot.rawValue {
            return commicList.comics!.count > 3 ? 3 : commicList.comics!.count
        }else if commicList.comicType == CTComicType.Secial.rawValue {
            return commicList.comics!.count > 2 ? 2 : commicList.comics!.count
        }else if commicList.comicType == CTComicType.DayUpdate.rawValue {
            return commicList.comics!.count > 2 ? 2 : commicList.comics!.count
        }else if commicList.comicType == CTComicType.HotNew.rawValue {
            return commicList.comics!.count > 1 ? 1 : commicList.comics!.count
        }else if commicList.comicType == CTComicType.New.rawValue {
            return commicList.comics!.count > 2 ? 2 : commicList.comics!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 0
        if section > 0 {
            height = 40
        }
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let commicList = commicLists[indexPath.section]
        if commicList.comicType == CTComicType.Top.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRTopCell", for: indexPath) as! CTRTopCell
            cell.configure(commicList.comics![indexPath.row])
            return cell
        }else if commicList.comicType == 12 || commicList.comicType == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRecommendCell", for: indexPath) as! CTRecommendCell
            cell.configureR(commicList.comics![indexPath.row])
            return cell
        }else if commicList.comicType == CTComicType.Hot.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRecommendCell", for: indexPath) as! CTRecommendCell
            cell.configureH(commicList.comics![indexPath.row])
            return cell
        }else if commicList.comicType == CTComicType.Secial.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRSecialCell", for: indexPath) as! CTRSecialCell
            cell.configure(commicList.comics![indexPath.row])
            return cell
        }else if commicList.comicType == CTComicType.HotNew.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRHotNewCell", for: indexPath) as! CTRHotNewCell
            cell.configure(commicList.comics![indexPath.row])
            return cell
        }else if commicList.comicType == CTComicType.New.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTRecommendCell", for: indexPath) as! CTRecommendCell
            cell.configureN(commicList.comics![indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let commicList = commicLists[indexPath.section]
        let width = collectionView.bounds.size.width
        if commicList.comicType == CTComicType.Top.rawValue {
            return CGSize(width: (width - 15) / 4, height: 60)
        }else if commicList.comicType == 12 || commicList.comicType == 3 || commicList.comicType == 9 {
            return CGSize(width: (width - 2.5) / 2, height: 140)
        }else if commicList.comicType == CTComicType.Hot.rawValue {
            return CGSize(width: (width - 5) / 3, height: 200)
        }else if commicList.comicType == CTComicType.Secial.rawValue {
            return CGSize(width: (width - 2.5) / 2, height: 100)
        }else if commicList.comicType == CTComicType.HotNew.rawValue {
            return CGSize(width: width, height: 130)
        }
        return CGSize(width: view.bounds.size.width, height: WIDTH / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CTRFooterReusableView", for: indexPath)
            return footer
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CTRHeaderReusableView", for: indexPath) as! CTRHeaderReusableView
            header.delegate = self
            header.tag = indexPath.section
            header.configure(commicLists[indexPath.section])
            return header
        }
        
    }

}

extension CTHRecommendViewController: CTRHeaderReusableViewProtocol {
    func headerShowMore(_ reusableView: CTRHeaderReusableView) {
        print(reusableView.tag)
    }
}

extension CTHRecommendViewController: CTCycleViewProtocol {
    func showComic(_ comicId: String) {
        let vc = UComicViewController(Int(comicId)!)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CTHRecommendViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cycleViewTopLayout.constant = min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))
    }
}
