//
//  USComicModel.swift
//  cartoon
//
//  Created by yanzhen on 2018/2/7.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

@objcMembers
class USComicModel: NSObject {

    init(_ keysValues: [String : Any]) {
        super.init()
        setValuesForKeys(keysValues)
    }
    
    var accredit: Int = 0
    var name: String = ""
    var comic_id: Int = 0
    var short_description: String = ""
    var cover: String = ""
    var is_vip: Int = 0
    var type: Int = 0
    var ori: String = ""
    var theme_ids: [String]?
    var series_status: Int = 0
    var last_update_time: TimeInterval = 0
    var description_new: String = ""
    var cate_id: String = ""
    var status: Int = 0
    var thread_id: Int = 0
    var last_update_week: String = ""
    var wideCover: String = ""
    var classifyTags: [UClassifyTags]?
    var is_week: Bool = false
    var comic_color: String?
    var author: UComicAuthor?
    var is_dub: Bool = false
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "description" {
            if let newValue = value {
                description_new = newValue as! String
            }
        }else if key == "classifyTags" {
            if let tag = value {
                let tags = tag as! [[String : Any]]
                var tags_r = [UClassifyTags]()
                for tagDict in tags {
                    let comic = UClassifyTags()
                    comic.setValuesForKeys(tagDict)
                    tags_r.append(comic)
                }
                classifyTags = tags_r
            }
        }else if key == "author" {
            if let authorD = value {
                author = UComicAuthor()
                author?.setValuesForKeys(authorD as! [String : Any])
            }
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

@objcMembers
class UClassifyTags: NSObject {
    var argName: String = ""
    var argVal: Int = 0
    var name: String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

@objcMembers
class UComicAuthor: NSObject {
    var avatar: String = ""
    var id: Int = 0
    var name: String = ""
    var cate_id: String = ""
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
