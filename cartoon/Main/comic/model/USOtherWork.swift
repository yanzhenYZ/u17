//
//  USOtherWork.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/7.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class USOtherWork: NSObject {
    
    init(_ keysValues: [String : Any]) {
        super.init()
        self.setValuesForKeys(keysValues)
    }
    
    var comicId: String = ""
    var coverUrl: String = ""
    var name: String = ""
    var passChapterNum: String = ""
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

