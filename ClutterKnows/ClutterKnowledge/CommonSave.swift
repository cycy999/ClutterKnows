//
//  CommonSave.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/9.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class CommonSave {

    //保存UserDefaults
    class func setUserDefaults(_ name: String, object: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: name)
        defaults.synchronize()
    }
    
    //获取UserDefaults的值
    class func getUserDefaults(_ name: String) -> AnyObject {
        let defaults = UserDefaults.standard
        if let object = defaults.object(forKey: name) {
            return object as AnyObject
        } else {
            return "" as AnyObject
        }
    }
    
}
