//
//  UCommentViewController.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/6.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UCommentViewController: UITableViewController {

    private var startOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1234")
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1234", for: indexPath)
        
        cell.textLabel?.text = String(indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}

extension UCommentViewController {
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
