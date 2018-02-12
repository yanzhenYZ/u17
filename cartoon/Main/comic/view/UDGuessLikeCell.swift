//
//  UDGuessLikeCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/12.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDGuessLikeCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var comics = [UGuessComic]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: "UDLikeCell", bundle: nil), forCellWithReuseIdentifier: "UDLikeCell")
    }

    public func configure(_ comics: [UGuessComic]) {
        self.comics.removeAll()
        self.comics += comics
        collectionView.reloadData()
    }
    
}

extension UDGuessLikeCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count > 4 ? 4 : comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UDLikeCell", for: indexPath) as! UDLikeCell
        cell.configure(comics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (WIDTH - 50) / 4, height: 150)
    }
}
