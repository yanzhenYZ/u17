//
//  UDMonthCell.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/12.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class UDMonthCell: UITableViewCell {

    @IBOutlet private weak var monthDetailLabel: UILabel!
    public func configure(_ comic: UDComicModel) {
        let text = NSMutableAttributedString(string: "本月月票       |     累计月票  ")
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.orange, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)]
        var totalTicket = String(comic.total_ticket)
        if comic.total_ticket > 10000 {
            totalTicket = String(format: "%.2f万", Double(comic.total_ticket) / 10000)
        }
        
        text.append(NSAttributedString(string: totalTicket, attributes: attributes))
        text.insert(NSAttributedString(string: String(comic.monthly_ticket), attributes: attributes), at: 6)
        monthDetailLabel.attributedText = text
    }
    
}
