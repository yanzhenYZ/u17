//
//  CTComicList.swift
//  cartoon
//
//  Created by yanzhen on 2018/1/9.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

//11-12强力推荐作品-7人气推荐作品&今日更新&恋爱&青年&生活-5专题-3条漫每日更新-13热门新品-9最新动画-
enum CTComicType: Int {
    case None
    case DayUpdate = 3
    case Secial = 5
    case Hot = 7
    case New = 9
    case Top = 11
    case Recommend
    case HotNew
}

@objcMembers
class CTComicList: NSObject {

    var argName: String = ""
    var argType: Int = 0
    var argValue: Int = 0
    var canedit: Int = 0
    var sortId: Int = 0
    
    var comicType: Int = 0
    var description_new: String = ""
    var itemTitle: String = ""
    var newTitleIconUrl: String = ""
    var titleIconUrl: String = ""
    
    var comics: [CTComic]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "description" {
            if let newValue = value {
                description_new = newValue as! String
            }
        }else if key == "comics" {
            if let comics_1 = value {
                let comics_arr = comics_1 as! [[String : Any]]
                var comics_r = [CTComic]()
                for comicDict in comics_arr {
                    let comic = CTComic()
                    comic.setValuesForKeys(comicDict)
                    comics_r.append(comic)
                }
                comics = comics_r
            }
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}

@objcMembers
class CTComic: NSObject {
    var author_name: String = ""
    
    var cover: String = ""
    var name: String = ""
    
    var clickNum: Int = 0
    var comicId: Int = 0
    var cornerInfo: String = ""
    var description_new: String = ""
    var is_vip: Int = 0
    var short_description: String = ""
    var subTitle: String = ""
    var tags: [String]?
    //for new
    var title: String = ""
    var content: String  = ""
    //big cover
    var wideCover: String = ""
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "description" {
            if let newValue = value {
                description_new = newValue as! String
            }
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
