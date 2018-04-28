//
//  UIView+Extension.swift
//
//
//  Created by LXF on 16/3/29.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }

    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    /// 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }

    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }

    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }

    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }


    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }

    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }

}

extension UIView {
//MARK: -圆角化卡顿方法
    //view.layer.shouldRasterize = YES
    //当shouldRasterize设成true时，layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。实现圆角本身就是在做颜色混合（blending），如果每次页面出来时都blending，消耗太大，这时shouldRasterize = yes，下次就只是简单的从渲染引擎的cache里读取那张bitmap，节约系统资源。
    //额外收获：如果在滚动tableView时，每次都执行圆角设置，肯定会阻塞UI，设置这个将会使滑动更加流畅。
    
    /*
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     //栅格化
     //异步绘制
     self.layer.shouldRasterize = true
     //栅格化必须制定分辨率，否则默认使用 *1 生成图像
     self.layer.rasterizationScale = UIScreen.main.scale
     
     }
     对于scale属性需要做进一步的说明：
     以前的iphone 设备屏幕分辨率都是320*480，后来apple 在iPhone 4中采用了名为Retina的显示技术，iPhone 4采用了960x640像素分辨率的显示屏幕。由于屏幕大小没有变，还是3.5英寸，分辨率的提升将iPhone 4的显示分辨率提升至iPhone 3GS的四倍，每英寸的面积里有326个像素。
     scale属性的值有两个：
     scale = 1; 的时候是代表当前设备是320*480的分辨率（就是iphone4之前的设备）
     scale = 2; 的时候是代表分辨率为640*960的分辨率
     */
    func test() {
        //UIScreen.main.scale
    }
}
