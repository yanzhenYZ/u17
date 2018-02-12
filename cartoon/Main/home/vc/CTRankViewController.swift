//
//  CTRankViewController.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/14.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

class CTRankViewController: UITableViewController {

    private var rankings = [CTHRankList]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(displayP3Red: 235 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
        tableView.rowHeight = 140
        tableView.sectionFooterHeight = 10
        tableView.separatorStyle = .none
        tableView.u17Header = U17RefreshView(block: { [weak self] in
            self?.getRankData()
        })
        tableView.register(UINib.init(nibName: "CTHRankingCell", bundle: nil), forCellReuseIdentifier: "CTHRankingCell")
        getRankData()
    }

    private func getRankData() {
        CTHttpTool.get(.Rank, success: { (response) in
            let returnData = response["data"]!["returnData"] as! [String : Any]
            let rankinglist = returnData["rankinglist"] as! [[String : Any]]
            self.rankings.removeAll()
            for ranking in rankinglist {
                let rank = CTHRankList()
                rank.setValuesForKeys(ranking)
                self.rankings.append(rank)
            }
            self.tableView.u17Header?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.u17Header?.endRefreshing()
            print("get rank error \(error.localizedDescription)")
        }
    }
    
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rankings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTHRankingCell", for: indexPath) as! CTHRankingCell
        cell.configure(rankings[indexPath.section])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
