//
//  CornerRaidons.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/3/23.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class CornerRaidons: UIView {

    //圆角化卡顿方法
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
