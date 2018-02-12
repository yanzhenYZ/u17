//
//  CTCRanking.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/5.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class CTCRanking: NSObject {

    var argName: String = ""
    var argValue: Int = 0
    var canEdit: Bool = false
    var cover: String = ""
    var isLike: Bool = false
    var sortId: Int = 0
    var sortName: String = ""
    init(_ keyValues: [String : Any]) {
        super.init()
        setValuesForKeys(keyValues)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
