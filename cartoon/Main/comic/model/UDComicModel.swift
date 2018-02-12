//
//  UDComicModel.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/7.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class UDComicModel: NSObject {

    init(_ keysValues: [String : Any]) {
        super.init()
        setValuesForKeys(keysValues)
    }
    
    var click_total: String = ""
    var comic_id: String = ""
    var comment_total: Int = 0
    var favorite_total: String = ""
    var gift_total: String = ""
    var is_auto_buy: Int = 0
    var is_free: Int = 0
    var is_vip_buy: Bool = false
    var is_vip_free: Bool = false
    var monthly_ticket: Int = 0
    var status: String = ""
    var total_ticket: Int = 0
    var total_tucao: Int = 0
    var user_id: String = ""
    var vip_discount: Double = 0
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
