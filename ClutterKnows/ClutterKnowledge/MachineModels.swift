//
//  MachineModels.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/29.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit
import Foundation

class MachineModels: NSObject {

    let deviceName = UIDevice.current.name //获取设备名称
    let sysName = UIDevice.current.systemName //获取系统名称
    let sysVersion = UIDevice.current.systemVersion //获取系统版本
    let deviceUUID = UIDevice.current.identifierForVendor?.uuidString //获取设备唯一标识符
    let deviceModel = UIDevice.current.model //获取设备的型号
    
    
    
    
    func printDevice() {
        print(deviceName)
        print(sysName)
        print(sysVersion)
        print(deviceUUID)
        print(deviceModel)
        
        //App相关信息
        let infoDic = Bundle.main.infoDictionary
        let appVersion = infoDic?["CFBundleShortVersionString"] // 获取App的版本
        let appBuildVersion = infoDic?["CFBundleVersion"] // 获取App的build版本
        let appName = infoDic?["CFBundleDisplayName"] // 获取App的名称
        print(appVersion)
        print(appBuildVersion)
        print(appName)
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.startAnimating()
        activity.stopAnimating()
        
        let uuid = CFUUIDCreate
        
        let s = ModelMachine.modelFromSize(size: DEVICE_RECT.size)
        print(s)
    }
    
    
}

//MARK: - 通过屏幕判断大概机型（简易方法）
enum ModelMachineType {
    case model_4s // 4/4s
    case model_5s // 5/5s/5c
    case model_6s // 6/6s/7/8
    case model_6p // 6+/6s+/7+/8+
    case model_x  // x
}

class ModelMachine {
    
    class func modelFromSize(size: CGSize) -> ModelMachineType {
        if size.width == 375 && size.height == 812 {
            return .model_x
        } else if size.width == 414 && size.height == 736 {
            return .model_6p
        }  else if size.width == 375 && size.height == 667 {
            return .model_6s
        } else if size.width == 320 && size.height == 568 {
            return .model_5s
        }
        return .model_4s
    }
    
}


public enum DeviceModel : String {
    case Simulator = "Simulator/Sandbox",
    iPod1          = "iPod 1",
    iPod2          = "iPod 2",
    iPod3          = "iPod 3",
    iPod4          = "iPod 4",
    iPod5          = "iPod 5",
    iPad2          = "iPad 2",
    iPad3          = "iPad 3",
    iPad4          = "iPad 4",
    iPhone4        = "iPhone 4",
    iPhone4S       = "iPhone 4S",
    iPhone5        = "iPhone 5",
    iPhone5S       = "iPhone 5S",
    iPhone5C       = "iPhone 5C",
    iPadMini1      = "iPad Mini 1",
    iPadMini2      = "iPad Mini 2",
    iPadMini3      = "iPad Mini 3",
    iPadAir1       = "iPad Air 1",
    iPadAir2       = "iPad Air 2",
    iPhone6        = "iPhone 6",
    iPhone6plus    = "iPhone 6 Plus",
    iPhone6S       = "iPhone 6S",
    iPhone6Splus   = "iPhone 6S Plus",
    Unrecognized   = "?unrecognized?"
}

extension UIDevice{
    
    public var deviceModel: DeviceModel{
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafeMutablePointer(to: &systemInfo.machine) {_ in
            //ptr in String.fromCString(UnsafePointer<CChar>(ptr))
            
            
        }
        var modelMap : [ String : DeviceModel ] = [
            "i386"      : .Simulator,
            "x86_64"    : .Simulator,
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad2,5"   : .iPadMini1,
            "iPad2,6"   : .iPadMini1,
            "iPad2,7"   : .iPadMini1,
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPad4,1"   : .iPadAir1,
            "iPad4,2"   : .iPadAir2,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPhone7,1" : .iPhone6plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6Splus
        ]
        
//        if let model = modelMap[String.fromCString(modelCode!)!] {
//            return model
//        }
        
        return DeviceModel.Unrecognized
    }
}

