//
//  CTCTopModel.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/5.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class CTCTopModel: NSObject {

    var cover: String = ""
    var extra: [String : Any]?
    var sortId: String = ""
    var sortName: String = ""
    var uiWeight: Int = 0
    init(_ keyValues: [String : Any]) {
        super.init()
        setValuesForKeys(keyValues)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
