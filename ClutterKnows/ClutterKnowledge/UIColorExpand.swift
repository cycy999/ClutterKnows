//
//  UIColorExpand.swift
//  SideVCApp
//
//  Created by 陈岩 on 2018/1/2.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class UIColorExpand: UIColor {

    class func getColor(_ colorCode: String, alpha: Float = 1.0) -> UIColor
    {
        let scanner = Scanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    //随机颜色
    func randomColor() -> UIColor {
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
    
    func randomValue() -> CGFloat {
        return CGFloat(arc4random_uniform(256)) / 255
    }
    
    //字体默认的颜色
    class func fontDefaultColor()-> UIColor {
        return self.getColor("333333")
    }
    
    //字体普通灰色
    class func fontGrayColor()-> UIColor {
        return self.getColor("878787")
    }
    
    //字体通用绿色
    class func fontGreenColor()-> UIColor {
        return self.getColor("5fbc86")
    }
    
    //字体通用黄色
    class func fontYellowColor()-> UIColor {
        return self.getColor("f7a95a")
    }
    
    //分隔线的颜色
    class func separatorColor()-> UIColor {
        return self.getColor("efeff4")
    }
    
    //mask弹出层的颜色
    class func maskColor()-> UIColor {
        return UIColor(white:0, alpha: 0.6)
    }
    
    //tableview背景色
    class func tableViewBackGroundColor()-> UIColor {
        return self.getColor("efeff4")
    }
    
    class func viewBackGroundColor()-> UIColor {
        return self.getColor("efeff4")
    }
    
    class func lineColor()-> UIColor {
        return self.getColor("dfdfe4")
    }
}
