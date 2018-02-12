//
//  CTHttpTool.swift
//  cartoon
//
//  Created by yanzhen on 2017/12/15.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit
import Alamofire

private let CTKey = "fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"

enum U17API {
    case Recommend
    case VIP
    case Subscribe
    case Rank
    case SearchHot
    case CateList
    case DetailStatic(comicID: Int)
    case DetailRealtime(comicID: Int)
    case GuessLike
}

class CTHttpTool: NSObject {

    class func get(_ u17Api: U17API,  success:(([String : AnyObject]) -> Void)?, failure:((Error) -> Swift.Void)?) {
        let urlStr = CTBaseURL + self.getAPIURLStr(u17Api)
        let parameters = self.getParameters(u17Api)
        Alamofire.request(urlStr, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                success?(response.result.value as! [String: AnyObject])
            }else{
                failure?(response.result.error!)
            }
        }
    }
    
    class private func getParameters(_ key: U17API) -> [String : Any] {
        var parameters = self.baseParameters()
        switch key {
        case .Recommend:
            parameters["sexType"] = 1
            parameters["v"] = 3320101
        case .CateList:
            parameters["v"] = 2
        case .DetailStatic(let comicID),
             .DetailRealtime(let comicID):
            parameters["comicid"] = comicID
            parameters["v"] = 3320101
        default:
            break
        }
        return parameters
    }
    
    class private func getAPIURLStr(_ key: U17API) -> String {
        var api = ""
        switch key {
        case .Recommend:
            api = "comic/boutiqueListNew"
        case .VIP:
            api = "list/vipList"
        case .Subscribe:
            api = "list/newSubscribeList"
        case .Rank:
            api = "rank/list"
        case .SearchHot:
            api = "search/hotkeywordsnew"
        case .CateList:
            api = "sort/mobileCateList"
        case .DetailStatic:
            api = "comic/detail_static_new"
        case .DetailRealtime:
            api = "comic/detail_realtime"
        case .GuessLike:
            api = "comic/guessLike"
        default: break
        }
        return api
    }
    
    class private func baseParameters() -> [String : Any] {
        let time = Int(Date().timeIntervalSince1970)
        let device_id = UIDevice.current.identifierForVendor?.uuidString
        let target = "U17_3.0"
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        return ["time" : time, "device_id" : device_id!, "key" : CTKey, "model" : self.modelName(), "target" : target, "version" : version]
    }
    
    class private func modelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
            
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        
        }
    }
}
