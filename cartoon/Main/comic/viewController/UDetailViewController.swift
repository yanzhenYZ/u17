//
//  UDetailViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/6.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDetailViewController: UITableViewController {
    
    private var startOffsetY: CGFloat = 0
    private var scomic: USComicModel!
    private var dcomic: UDComicModel!
    private var works = [USOtherWork]()
    private var comics = [UGuessComic]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 235 / 255.0, green: 235 / 255.0, blue: 241 / 255.0, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1234")
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "UDDescriptionCell", bundle: nil), forCellReuseIdentifier: "UDDescriptionCell")
        tableView.register(UINib.init(nibName: "UDMoreWorksCell", bundle: nil), forCellReuseIdentifier: "UDMoreWorksCell")
        tableView.register(UINib.init(nibName: "UDMonthCell", bundle: nil), forCellReuseIdentifier: "UDMonthCell")
        tableView.register(UINib.init(nibName: "UDGuessLikeCell", bundle: nil), forCellReuseIdentifier: "UDGuessLikeCell")
    }
    
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if scomic == nil {
            return 0
        }
        return works.count > 0 ? 4 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if works.count > 0 {
            if section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UDMoreWorksCell", for: indexPath) as! UDMoreWorksCell
                cell.accessoryType = .disclosureIndicator
                cell.countLabel.text = String(works.count) + "本"
                return cell
            } else if section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UDMonthCell", for: indexPath) as! UDMonthCell
                cell.configure(dcomic)
                return cell
            } else if section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UDGuessLikeCell", for: indexPath) as! UDGuessLikeCell
                cell.configure(comics)
                return cell
            }
        } else {
            if section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UDMonthCell", for: indexPath) as! UDMonthCell
                cell.configure(dcomic)
                return cell
            } else if section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UDGuessLikeCell", for: indexPath) as! UDGuessLikeCell
                cell.configure(comics)
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UDDescriptionCell", for: indexPath) as! UDDescriptionCell
        cell.accessoryType = .none
        cell.setDescription(scomic.description_new)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if works.count > 0 {
            if section == 1 || section == 2 {
                return 50
            }else if section == 3 {
                return 400
            }
        } else {
            if section == 1 {
                return 50
            }else if section == 2 {
                return 450
            }
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension UDetailViewController {
    public func setStaticDeatail(_ comic: USComicModel, otherWorks: [USOtherWork]) {
        scomic = comic
        works = otherWorks
    }
    
    public func setRealtimeDetail(_ comic: UDComicModel) {
        dcomic = comic
    }
    
    public func setGuessLikeComics(_ likes: [UGuessComic]) {
        comics = likes
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
}

extension UDetailViewController {
    private weak var parentVC: UComicViewController! {
        get {
            return parent as! UComicViewController
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetY = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //not 0
        if scrollView.contentOffset.y < 0 {
            //can't < 0
            parentVC.subScrollViewDidScroll(false, start: false)
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
        }else if scrollView.contentOffset.y > 0 {
            if !parentVC.subScrollViewDidScroll(true, start: startOffsetY == 0) && startOffsetY == 0 {
                scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
            }
        }
    }
}
