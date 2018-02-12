//
//  CTGallery.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/8.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class CTGallery: NSObject {

    var content: String = ""
    var cover: String = ""
    var ext: [[String : String]]?
    var id: Int = 0
    var linkType: Int = 0
    var title: String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
