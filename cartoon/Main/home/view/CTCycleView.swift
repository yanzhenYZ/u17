//
//  CTCycleView.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/14.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

protocol CTCycleViewProtocol: NSObjectProtocol {
    func showComic(_ comicId: String)
}

class CTCycleView: UIView {

    public weak var delegate: CTCycleViewProtocol?
    private var gallerys = [CTGallery]()
    private var timer: Timer?
    @IBOutlet private weak var pageControl: CTPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "CTCycleCell", bundle: nil), forCellWithReuseIdentifier: "CTCycleCell")
        pageControl.setValue(#imageLiteral(resourceName: "boutique_page"), forKeyPath: "pageImage")
        pageControl.setValue(#imageLiteral(resourceName: "boutique_page_current"), forKeyPath: "currentPageImage")
    }
    
    public func getAllData(_ galleryData: [[String : Any]]) {
        gallerys.removeAll()
        for galleryDict in galleryData {
            let gallery = CTGallery()
            gallery.setValuesForKeys(galleryDict)
            gallerys.append(gallery)
        }
        pageControl.numberOfPages = gallerys.count
        if gallerys.count == 0 { return }
        collectionView.reloadData()
        let indexPath = IndexPath(item: gallerys.count * 100, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        removeTimer()
        addTimer()
    }
    
    private func addTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [weak self] (timer) in
            if let weakSelf = self {
                self?.collectionView.setContentOffset(CGPoint(x: weakSelf.collectionView.contentOffset.x + weakSelf.collectionView.bounds.size.width, y: 0), animated: true)
            }
        })
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension CTCycleView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallerys.count * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTCycleCell", for: indexPath) as! CTCycleCell
        cell.configure(gallerys[indexPath.row % gallerys.count])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: WIDTH, height: WIDTH * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gallery = gallerys[indexPath.row % gallerys.count]
        delegate?.showComic(gallery.ext![0]["val"]!)
    }
}

extension CTCycleView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % gallerys.count
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
}
