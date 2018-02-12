//
//  UComicViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/6.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UComicViewController: UIViewController {

    @IBOutlet private weak var hiddenView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var coverImgView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var topViewHLayout: NSLayoutConstraint!
    @IBOutlet private weak var iconImgView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var tagsView: UIView!
    @IBOutlet private weak var clickLabel: UILabel!
    @IBOutlet private weak var topBarView: UIView!
    private var selectedBtn: UIButton!
    
    private var detailVC: UDetailViewController!
    private var catalogVC: UCatalogViewController!
    private var commentVC: UCommentViewController!
    private var chapters = [USChapterList]()
    private var comicID: Int = 0
    convenience init(_ comicID: Int) {
        self.init()
        self.comicID = comicID
        print(comicID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        getAllData()
    }
    
    @discardableResult
    public func subScrollViewDidScroll(_ up: Bool, start: Bool) -> Bool {
        if up {
            if topViewHLayout.constant == 64 {
                return true
            }
            if start {
                UIView.animate(withDuration: 0.25, animations: {
                    self.topViewHLayout.constant = 64
                }, completion: { (finished) in
                    self.hiddenView.isHidden = false
                })
            }
        } else {
            //下拉就回复
            if topViewHLayout.constant == 64 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.topViewHLayout.constant = 214
                }, completion: { (finished) in
                    self.hiddenView.isHidden = true
                })
            }
        }
        return false
    }
    
    @IBAction private func topBarBtnAction(_ sender: UIButton) {
        if sender.isSelected { return }
        scrollView.setContentOffset(CGPoint(x: WIDTH * CGFloat(sender.tag - 10), y: 0), animated: true)
    }
    
    @IBAction private func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension UComicViewController: UIScrollViewDelegate {
    //scrollView.setContentOffset will call this method
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / WIDTH) + 10
        let btn = topBarView.viewWithTag(index) as! UIButton
        selectedBtn.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
    }
}

private extension UComicViewController {
    func getAllData() {
        getDetailStatic()
        getDetailRealtime()
    }
    
    func getDetailRealtime() {
        let group = DispatchGroup()
        group.enter()
        
        //http://app.u17.com/v3/appV3_3/ios/phone/comic/detail_realtime?device_id=7D495599-CE39-4900-BD9F-8D95619A46E2&key=fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986%3A%3A%3Aopen&model=iPhone%205s&comicid=149716&target=U17_3.0&time=1516691278&v=3320101&version=3.3.3
        CTHttpTool.get(.DetailRealtime(comicID: comicID), success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let comic = returnData["comic"] as! [String : Any]
            let chapter_list = returnData["chapter_list"] as! [[String : Any]]
            
//            for chapterD in chapter_list {
//                let chapter = USChapterList()
//                chapter.setValuesForKeys(chapterD)
//                self.chapters.append(chapter)
//            }
            
            let dcomic = UDComicModel(comic)
            self.setClick(dcomic)
            
            self.detailVC.setRealtimeDetail(dcomic)
            
            group.leave()
        }) { (error) in
            print("get detail static error: \(error.localizedDescription)")
        }
        
        group.enter()
        CTHttpTool.get(.DetailStatic(comicID: comicID), success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let comic = returnData["comic"] as! [String : Any]
            let chapter_list = returnData["chapter_list"] as! [[String : Any]]
            let otherWorks = returnData["otherWorks"] as! [[String : Any]]
            
            self.chapters += chapter_list.map { USChapterList($0) }
            let works = otherWorks.map { USOtherWork($0) }

            let scomic = USComicModel(comic)
            self.configureTop(scomic)
            
            self.detailVC.setStaticDeatail(scomic, otherWorks: works)
            group.leave()
        }) { (error) in
            group.leave()
            print("get detail static error: \(error.localizedDescription)")
        }
        
        group.enter()
        CTHttpTool.get(.GuessLike, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let comics = returnData["comics"] as! [[String : Any]]
            let gcomics = comics.map { UGuessComic($0) }
            self.detailVC.setGuessLikeComics(gcomics)
            group.leave()
        }) { (error) in
            group.leave()
            print("get guess like error: \(error.localizedDescription)")
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.detailVC.reloadData()
        }
    }
    
    func getDetailStatic() {
        //http://app.u17.com/v3/appV3_3/ios/phone/comic/detail_static_new?device_id=7D495599-CE39-4900-BD9F-8D95619A46E2&key=fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986%3A%3A%3Aopen&model=iPhone%205s&comicid=149716&target=U17_3.0&time=1516691278&v=3320101&version=3.3.3
        //http://app.u17.com/v3/appV3_3/ios/phone/comic/guessLike?device_id=7D495599-CE39-4900-BD9F-8D95619A46E2&key=fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986%3A%3A%3Aopen&model=iPhone%205s&comicid=149716&target=U17_3.0&time=1516691278&v=3320101&version=3.3.3
    }
}

private extension UComicViewController {
    func configureUI() {
        selectedBtn = topBarView.viewWithTag(10) as! UIButton
        iconImgView.layer.borderColor = UIColor.white.cgColor
        for subView in tagsView.subviews {
            subView.layer.masksToBounds = true
            subView.layer.cornerRadius = 2
            subView.layer.borderColor = UIColor.white.cgColor
            subView.layer.borderWidth = 0.2
        }
        
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        detailVC = UDetailViewController()
        addChildViewController(detailVC)
        detailVC.view.frame = CGRect(x: 0, y: 0, width: vcW, height: vcH)
        scrollView.addSubview(detailVC.view)
        
        catalogVC = UCatalogViewController()
        addChildViewController(catalogVC)
        catalogVC.view.frame = CGRect(x: WIDTH, y: 0, width: vcW, height: vcH)
        scrollView.addSubview(catalogVC.view)
        
        commentVC = UCommentViewController()
        addChildViewController(commentVC)
        commentVC.view.frame = CGRect(x: WIDTH * 2, y: 0, width: vcW, height: vcH)
        scrollView.addSubview(commentVC.view)
        
        scrollView.contentSize = CGSize(width: WIDTH * 3, height: 0)
    }
    
    func setClick(_ comic: UDComicModel) {
        let text = NSMutableAttributedString(string: "点击 收藏 ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)])
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.orange, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        text.insert(NSAttributedString(string: " \(comic.click_total) ", attributes: attributes), at: 2)
        
        var favorite = comic.favorite_total
        if Int(comic.favorite_total)! > 10000 {
            favorite = String(format: "%.2f万", Double(comic.favorite_total)! / 10000)
        }
        text.append(NSAttributedString(string: " \(favorite) ", attributes: attributes))
        self.clickLabel.attributedText = text
    }
    
    func configureTop(_ comic: USComicModel) {
        coverImgView.kf.setImage(with: URL(string: comic.cover), placeholder: #imageLiteral(resourceName: "normal_placeholder_h"))
        iconImgView.kf.setImage(with: URL(string: comic.ori), placeholder: #imageLiteral(resourceName: "normal_placeholder_v"))
        nameLabel.text = comic.name
        titleLabel.text = comic.name
        authorNameLabel.text = comic.author?.name
        guard let count = comic.classifyTags?.count else { return }
        let subCount  = count > 3 ? 3 : count
        for i in 0..<subCount {
            let classify = comic.classifyTags![i]
            let subLabel = tagsView.viewWithTag(i + 100) as! UILabel
            subLabel.isHidden = false
            subLabel.text = classify.name
        }
    }
}
