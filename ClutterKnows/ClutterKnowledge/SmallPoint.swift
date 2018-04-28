//
//  SmallPoint.swift
//  SideVCApp
//
//  Created by 陈岩 on 2018/1/2.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

let screen:UIScreen = UIScreen.main
let DEVICE_RECT:CGRect = screen.bounds
let DEVICE_WIDTH = DEVICE_RECT.size.width
let DEVICE_HEIGHT = DEVICE_RECT.size.height

//重置控制台打印数据
func MYLog<T>(_ message:T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
    #endif
}

class SmallPoint: NSObject {
    //MARK: - 1、获取一个唯一标识符
    class func get_unique_id() -> String {
        let data = Date()
        let timeInterval = data.timeIntervalSince1970*1000
        let random = arc4random_uniform(10000) + 10000
        let unique_id = ("\(timeInterval)" + "\(random)").replacingOccurrences(of: ".", with: "")
        return unique_id
    }
    
    //MARK: - 2、获取当前正在显示的控制器，push 和 present 都ok
    func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController {
        if vc.isKind(of: UINavigationController.self) {
            if let vcc = (vc as! UINavigationController).visibleViewController {
                return self.getVisibleViewControllerFrom(vcc)
            }
        } else if vc.isKind(of: UITabBarController.self) {
            if let vcc = (vc as! UITabBarController).selectedViewController {
                return getVisibleViewControllerFrom(vcc)
            }
        } else {
            if (vc.presentedViewController != nil) {
                return self.getVisibleViewControllerFrom(vc.presentedViewController!)
            }
        }
        return vc
    }
    
    //MARK: - 3、给一个 view 截图
    func screenHots(_ view:UIView) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //MARK: - 4、虚线
    class func addDottedLine(_ view: UIView) {
        
        let dd = CAShapeLayer()
        let mdotteShapePath = CGMutablePath()
        dd.fillColor = UIColor.clear.cgColor
        dd.strokeColor = UIColor.viewBackGroundColor().cgColor
        dd.lineWidth = 1.0
        mdotteShapePath.move(to: CGPoint(x: 0, y: 0))
        mdotteShapePath.addLine(to: CGPoint(x: DEVICE_WIDTH - 10, y: 0))
        //        CGPathMoveToPoint(mdotteShapePath, nil, 0, 0)
        //        CGPathAddLineToPoint(mdotteShapePath, nil, DEVICE_WIDTH - 10, 0)
        dd.path = mdotteShapePath
        let arr = NSArray(array: [4,2])
        dd.lineDashPhase = 1.0
        dd.lineDashPattern = arr as? [NSNumber]
        view.layer.addSublayer(dd)
    }
    
    //MARK: - 5、不同字段设置不同颜色
    class func setAttributedText(_ str:String,
                                 location:Int,length:Int,
                                 color:UIColor) -> NSMutableAttributedString {
        let myMutableString = NSMutableAttributedString(string: str)
        myMutableString.addAttributes([NSAttributedStringKey.foregroundColor:color], range: NSRange(location: location,length: length))
        return myMutableString
    }
    
    class func setAttributedText(_ str:String,font:CGFloat,location:Int,length:Int,color:UIColor) -> NSMutableAttributedString {
        let myMutableString = NSMutableAttributedString(string: str)
        let fontt = UIFont.systemFont(ofSize: font)
        myMutableString.addAttributes([NSAttributedStringKey.font:fontt,NSAttributedStringKey.foregroundColor:color], range: NSRange(location: location,length: length))
        return myMutableString
    }
    
    func testAttributeString() {
        let a = NSMutableAttributedString(string: "已选项目 ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.getColor("333333")])
        
        a.append(NSAttributedString(string: "66", attributes: [NSAttributedStringKey.foregroundColor: UIColor.getColor("45B173")]))
        
        UILabel().attributedText = a
    }
    
//    MARK: - lineBreakMode：设置标签文字过长时的显示方式。
//    label.lineBreakMode = NSLineBreakByCharWrapping;    //以字符为显示单位显示，后面部分省略不显示。
//    label.lineBreakMode = NSLineBreakByClipping;        //剪切与文本宽度相同的内容长度，后半部分被删除。
//    label.lineBreakMode = NSLineBreakByTruncatingHead;  //前面部分文字以……方式省略，显示尾部文字内容。
//    label.lineBreakMode = NSLineBreakByTruncatingMiddle;    //中间的内容以……方式省略，显示头尾的文字内容。
//    label.lineBreakMode = NSLineBreakByTruncatingTail;  //结尾部分的内容以……方式省略，显示头的文字内容。
//    label.lineBreakMode = NSLineBreakByWordWrapping;    //以单词为显示单位显示，后面部分省略不显示。
    
    //navigationBar底部的黑（白）线 //获取到的view隐藏即可隐藏navigationbar底部的白线
    func findNavBarHarLineImageView(v: UIView) -> UIView? {
        if v.isKind(of: UIImageView.self) && v.bounds.size.height <= 1{
            return v
        }
        for subview in v.subviews {
            if let img = self.findNavBarHarLineImageView(v: subview) {
                return img
            }
        }
        return nil
    }
    //navBarHairlineImageView = findNavBarHarLineImageView(v: (navigationController?.navigationBar)!)
}

//关于支付宝支付的相关参数，可做参考
//alipay.pay(sign: "app_id=20177383904816397&method=alipay.trade.app.pay&charset=utf-8&sign_type=RSA2&timestamp=2017-06-30 14:59:58&version=1.0&format=json&notify_url=http://ceshidizhi.com:8080/store-manage/payment/callback/notifyAlipayApp.ihtml&biz_content={\"total_amount\":\"0.01\",\"timeout_express\":\"30m\",\"product_code\":\"QUICK_MSECURITY_PAY\",\"subject\":\"测试商品1\",\"out_trade_no\":\"10120170630123671234537281\"}&sign=df15Q+AQ3lZLlF95wNdXKRpc35nmpDeEL8XrlIlTbfTQE39Z+RTRrOlSxuBtAqZpCzZy0ulxlkI64Y85PFiU9E6x+vnaimFTMuVNUYqasfdsaNaH3+85dhTk5u0SxV5n/fOrklx+B1SzADl4218/lhjz4bNnMqE6lXiJAFdfasdsafdsafasfdsqZDFjmJxmnjI9nfH74lEP+yF4X68uRsdUFrXaEt2CciyL2RVNj5ZJcJ7njjwtAcgdcHblA6j6qHqFRnrvdxV5i5VGQn1SHwpvMEAdsadsa1mBl7kDlCpWh/M1chCNdB79e3B1O8KsX7Iaz8g2snBr/y/wHU7YHfsnuLw==}")

extension UIView {
    //isMy_label.frame = CGRect(x: 0, y: 0, width: 37, height: 25)
    //isMy_label.addCorner(corner, cornerSize: CGSize(width: 12.5, height: 12.5))
    //MARK: - 6、改变单个或多个角为圆角
    func addCorner(_ roundingCorners: UIRectCorner, cornerSize: CGSize) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        //cornerLayer.mask = cornerLayer
        layer.mask = cornerLayer
    }
    
    func addDottedLine(_ color:UIColor) {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.position = self.center
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [NSNumber.init(value: 3), NSNumber.init(value: 3)]
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height))
        path.addLine(to: CGPoint(x: self.frame.origin.x + self.frame.width, y: self.frame.origin.y + self.frame.height))
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
        
    }
    
    func old_addDottedLine(_ color:UIColor) {
        let dd = CAShapeLayer()
        let mdotteShapePath = CGMutablePath()
        dd.fillColor = UIColor.clear.cgColor
        dd.strokeColor = color.cgColor
        dd.lineWidth = 1.0
        mdotteShapePath.move(to: CGPoint(x: 0, y: 0))
        mdotteShapePath.addLine(to: CGPoint(x: 0, y: 1))
        //CGPathMoveToPoint(mdotteShapePath, nil, 0, 0)
        //CGPathAddLineToPoint(mdotteShapePath, nil, 0, 14)
        dd.path = mdotteShapePath
        let arr = NSArray(array: [4,2])
        dd.lineDashPhase = 1.0
        dd.lineDashPattern = arr as? [NSNumber]
        layer.addSublayer(dd)
    }
}
