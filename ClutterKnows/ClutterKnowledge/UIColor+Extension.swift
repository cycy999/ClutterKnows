//
//  UIColor+Extension.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func hexInt(_ hexValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       
                       alpha: 1.0)
    }
    //view.backgroundColor = UIColor.hexInt(0xf3f3f3)
    
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

