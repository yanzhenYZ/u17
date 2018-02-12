//
//  U17RefreshView.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/29.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

private let U17ImageW: CGFloat = 102
private let U17ImageH: CGFloat = 64

enum U17RefreshState {
    case Normal
    case WillRefresh
    case Refreshing
}

private var u17HeaderKey: UInt8 = 0
extension UIScrollView {
    var u17Header: U17RefreshView? {
        get {
            return objc_getAssociatedObject(self, &u17HeaderKey) as? U17RefreshView
        }
        set {
            if let u17View = newValue {
                u17View.removeFromSuperview()
                addSubview(u17View)
            }
            
            willChangeValue(forKey: "u17Header")
            objc_setAssociatedObject(self, &u17HeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            didChangeValue(forKey: "u17Header")
        }
    }
}

class U17RefreshView: UIView {
    
    public var normalImg: String = "refresh_normal"
    public var willRefreshImg: String = "refresh_will_refresh"
    public var animationImgs = ["refresh_loading_1", "refresh_loading_2", "refresh_loading_3"]
    private var refreshing: Bool = false
    private var initInset = UIEdgeInsets.zero
    private var state: U17RefreshState = .Normal
    private var beginRefreshBlock: (() -> Void)?
    private var showImgView: UIImageView = UIImageView()
    public weak var scrollView: UIScrollView!
    
    init(block: (() -> Void)?) {
        super.init(frame: CGRect.zero)
        autoresizingMask = [.flexibleWidth]
        backgroundColor = UIColor.clear
        showImgView.frame = CGRect(x: 0, y: 0, width: U17ImageW, height: U17ImageH)
        showImgView.contentMode = .scaleAspectFill
        showImgView.image = UIImage(named: normalImg)
        addSubview(showImgView)
        
        self.beginRefreshBlock = block
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //when dealloc need remover observer
        superview?.removeObserver(self, forKeyPath: "contentOffset", context: nil)
        guard let newView = newSuperview else {
            return
        }
        
        scrollView = newView as! UIScrollView
        initInset = scrollView.contentInset
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        frame = CGRect(x: 0, y: -U17ImageH, width: scrollView.frame.size.width, height: U17ImageH)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let u17KeyPath = keyPath, u17KeyPath == "contentOffset" else {
            return
        }
        if state == .Refreshing { return }
        if scrollView.isDragging {
            let offsetY = -scrollView.contentOffset.y
            if state == .Normal && offsetY > (U17ImageH + scrollView.contentInset.top) {
                setRefreshState(.WillRefresh)
            }else if (state == .WillRefresh && offsetY <= U17ImageH) {
                setRefreshState(.Normal)
            }
        } else {
            if state == .WillRefresh {
                setRefreshState(.Refreshing)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        showImgView.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension U17RefreshView {
    public var isRefreshing: Bool {
        get {
            return refreshing
        }
    }
    
    public func beginRefreshing() {
        setRefreshState(.Refreshing)
    }
    
    public func endRefreshing() {
        setRefreshState(.Normal)
    }
}

//private
extension U17RefreshView {
    private func setRefreshState(_ newState: U17RefreshState) {
        if state != .Refreshing {
            initInset = scrollView.contentInset
        }
        if state == newState { return }
        state = newState
        if state == .Normal {
            if showImgView.isAnimating {
                showImgView.stopAnimating()
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.contentInset = self.initInset
            }, completion: { (finished) in
                self.showImgView.image = UIImage(named: self.normalImg)
            })
        }else if state == .WillRefresh {
            showImgView.image = UIImage(named: willRefreshImg)
        }else{
            showImgView.animationImages = animationImgs.map({ UIImage(named: $0)! })
            showImgView.animationDuration = 0.5
            showImgView.startAnimating()
            beginRefreshBlock?()
            keepAnimation()
        }
    }
    
    private func backToIdentity() {
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentInset = self.initInset
        }
    }
    
    private func keepAnimation() {
        var inset = scrollView.contentInset
        inset.top += U17ImageH
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentInset = inset
        }
    }
}

