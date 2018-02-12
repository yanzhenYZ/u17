//
//  USChapterList.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/7.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class USChapterList: NSObject {
    
    init(_ keysValues: [String : Any]) {
        super.init()
        setValuesForKeys(keysValues)
    }
    
    var chapter_id: String = ""
    var countImHightArr: Int = 0
    var has_locked_image: Bool = false
    var image_total: String = ""
    var imHightArr: [[[String : String]]]?
    var is_new: Int = 0
    var name: String = ""
    var pass_time: Int = 0
    var price: String = ""
    var release_time: String = ""
    var size: String = ""
    var type: Int = 0
    var zip_high_webp: String = ""
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
