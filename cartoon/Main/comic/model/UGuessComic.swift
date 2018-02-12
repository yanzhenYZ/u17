//
//  UGuessComic.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/12.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class UGuessComic: NSObject {

    init(_ keysValues: [String : Any]) {
        super.init()
        setValuesForKeys(keysValues)
    }
    
    var comic_id: String = ""
    var cover: String = ""
    var name: String = ""
    var new_comic: Bool = false
    var ori_cover: String = ""
    var short_description: String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
