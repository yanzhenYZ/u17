//
//  CTCSearchViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/2.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class CTCSearchViewController: UIViewController {

    @IBOutlet private weak var searchTF: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var hotItems = [CTSHotItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTF.becomeFirstResponder()
        let layout = CTSCollectionViewAlignedLayout()
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)//new layout to set inset
        
        layout.estimatedItemSize = CGSize(width: 30, height: 30)
        collectionView.register(UINib.init(nibName: "CTSHotItemCell", bundle: nil), forCellWithReuseIdentifier: "CTSHotItemCell")
        getSearchHotData()
    }
    
    private func getSearchHotData() {
        CTHttpTool.get(.SearchHot, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let hotItems_s = returnData["hotItems"] as! [[String : Any]]
            self.hotItems.removeAll()
            for hot in hotItems_s {
                let item = CTSHotItem()
                item.setValuesForKeys(hot)
                self.hotItems.append(item)
                self.collectionView.reloadData()
            }
        }) { (error) in
            print("get search hot error: \(error.localizedDescription)")
        }
    }

    @IBAction private func cancelAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func refreshHotItems(_ sender: Any) {
        getSearchHotData()
    }
}

extension CTCSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTSHotItemCell", for: indexPath) as! CTSHotItemCell
        cell.configure(hotItems[indexPath.row])
        return cell
    }
    
    
}

extension CTCSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "text is nil")
        return true
    }
}
