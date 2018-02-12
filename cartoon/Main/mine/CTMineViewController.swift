//
//  CTMineViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/12.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTMineViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var headerView: UIView!
    private var titles: [[[String : String]]]!
    override func viewDidLoad() {
        super.viewDidLoad()

        titles = [[["icon":"mine_vip", "title": "我的VIP"],
                   ["icon":"mine_coin", "title": "充值妖气币"]],
                  
                  [["icon":"mine_accout", "title": "消费记录"],
                   ["icon":"mine_subscript", "title": "我的订阅"],
                   ["icon":"mine_seal", "title": "我的封印图"]],
                  
                  [["icon":"mine_message", "title": "我的消息/优惠券"],
                   ["icon":"mine_cashew", "title": "妖果商城"],
                   ["icon":"mine_freed", "title": "在线阅读免流量"]],
                  
                  [["icon":"mine_feedBack", "title": "帮助中心"],
                   ["icon":"mine_mail", "title": "我要反馈"],
                   ["icon":"mine_judge", "title": "给我们评分"],
                   ["icon":"mine_author", "title": "成为作者"],
                   ["icon":"mine_setting", "title": "设置"]]]
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
            edgesForExtendedLayout = []
        }
        view.backgroundColor = UIColor.green
        tableView.tableHeaderView = headerView
        tableView.u17Header = U17RefreshView(block: { [weak self] in
            self?.stopRefreshing()
        })
    }

    private func stopRefreshing() {
        let two = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: two) {
            self.tableView.u17Header?.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}

extension CTMineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
        }
        let dict = titles[indexPath.section][indexPath.row]
        cell?.textLabel?.text = dict["title"]
        cell?.imageView?.image = UIImage(named: dict["icon"]!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.contentInset)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
}
