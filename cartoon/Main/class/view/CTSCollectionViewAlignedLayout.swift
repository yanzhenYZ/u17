//
//  CTSCollectionViewAlignedLayout.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/2.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit
//align -- left
class CTSCollectionViewAlignedLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        if isFirstItemInLine(layoutAttributes) {
            layoutAttributes.frame.origin.x = sectionInset.left
        } else {
            alignToPreviousItem(layoutAttributes)
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)
        layoutAttributesObjects?.forEach({ (layoutAttributes) in
            if layoutAttributes.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                    layoutAttributes.frame = newFrame
                }
            }
        })
        return layoutAttributesObjects
    }
}

fileprivate extension CTSCollectionViewAlignedLayout {
    func isFirstItemInLine(_ layoutAttributes: UICollectionViewLayoutAttributes) -> Bool {
        let indexPath = layoutAttributes.indexPath
        if indexPath.item > 0 {
            let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            if let previousLayoutAttributes = super.layoutAttributesForItem(at: previousIndexPath) {
                let lineWidth = collectionView!.frame.size.width - sectionInset.left - sectionInset.right
                let lineFrame = CGRect(x: sectionInset.left, y: layoutAttributes.frame.origin.y, width: lineWidth, height: layoutAttributes.frame.size.height)
                //当前行的frame如果和前一个item.frame有交集，说明在同一行
                return !lineFrame.intersects(previousLayoutAttributes.frame)
            }
        }
        return true
    }
    
    private func alignToPreviousItem(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        let indexPath = layoutAttributes.indexPath
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        if let previousLayoutAttributes = layoutAttributesForItem(at: previousIndexPath) {
            layoutAttributes.frame.origin.x = previousLayoutAttributes.frame.maxX + minimumInteritemSpacing
        }
    }
}
