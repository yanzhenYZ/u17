//
//  CTCollectionViewFlowLayout.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/23.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

private let CTLayoutKind = "CTCollectionReusableView"
protocol CTCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor
}

class CTCollectionViewFlowLayout: UICollectionViewFlowLayout {

    public var backgroundColor: UIColor = UIColor.red
    private var decorationAttributes = [UICollectionViewLayoutAttributes]()
    override init() {
        super.init()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 2.5
        register(CTCollectionReusableView.classForCoder(), forDecorationViewOfKind: CTLayoutKind)
    }
    
    override func prepare() {
        super.prepare()
        guard let sections = collectionView?.numberOfSections, let delegate = collectionView?.delegate as? CTCollectionViewDelegateFlowLayout else {
            return
        }
        decorationAttributes.removeAll()
        for section in 0..<sections {
            let indexPath = IndexPath(item: 0, section: section)
            guard let items = collectionView?.numberOfItems(inSection: section), items > 0 else {
                continue
            }
            let firstAttributes = layoutAttributesForItem(at: indexPath)
            let lastAttributes = layoutAttributesForItem(at: IndexPath(item: items - 1, section: section))
            
            var inset = sectionInset
            if let userInset = delegate.collectionView?(collectionView!, layout: self, insetForSectionAt: section) {
                inset = userInset
            }
            var sectionFrame = firstAttributes!.frame.union(lastAttributes!.frame)
            sectionFrame.origin.x = inset.left
            sectionFrame.origin.y -= inset.top
            
            let header = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath)
            let footer = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: indexPath)
            sectionFrame.origin.y -= header?.frame.size.height ?? 0
            if scrollDirection == .vertical {
                sectionFrame.size.width = collectionView!.frame.size.width
                sectionFrame.size.height += inset.top + inset.bottom + (header?.frame.size.height ?? 0) + (footer?.frame.size.height ?? 0)
            }else{
                sectionFrame.size.width += inset.left + inset.right
                sectionFrame.size.height = collectionView!.frame.size.height + (header?.frame.size.height ?? 0) + (footer?.frame.size.height ?? 0)
            }
            let ctAttr = CTCollectionViewLayoutAttributes(forDecorationViewOfKind: CTLayoutKind, with: indexPath)
            ctAttr.frame = sectionFrame
            ctAttr.zIndex = -1
//            ctAttr.backgroundColor = backgroundColor
            ctAttr.backgroundColor = delegate.collectionView(collectionView!, layout: self, backgroundColorForSectionAt: section)
            decorationAttributes.append(ctAttr)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        attrs?.append(contentsOf: decorationAttributes.filter({rect.intersects($0.frame)}))
        return attrs
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == CTLayoutKind {
            return decorationAttributes[indexPath.section]
        }
        return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class CTCollectionReusableView: UICollectionReusableView {
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if layoutAttributes.isKind(of: CTCollectionViewLayoutAttributes.self) {
            let attr = layoutAttributes as! CTCollectionViewLayoutAttributes
            backgroundColor = attr.backgroundColor
        }
    }
}

private class CTCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    fileprivate var backgroundColor: UIColor = UIColor.white
}

