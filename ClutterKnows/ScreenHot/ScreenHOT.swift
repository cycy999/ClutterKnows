//
//  ScreenHOT.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/3/19.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class ScreenHOT: NSObject {

    class func getScreenImage() -> UIImage {
        let screenRect = UIScreen.main.bounds
        UIGraphicsBeginImageContext(screenRect.size)
        let ctxf: CGContext = UIGraphicsGetCurrentContext()!
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
        return image!
    }
    
    func screenSnapshot(save save: Bool) -> UIImage? {
        
        guard let window = UIApplication.shared.keyWindow else { return nil }
        
        // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        
        window.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if save { UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil) }
        
        return image
    }
   
}



class ScreensHot: NSObject {
    
    static let shareInstance = ScreensHot()
    
    var imgs = [UIImage]()
    
    var bugTitleStr = ""
    var bugDetailStr = ""
    
    func removeImgFormImgs() {
        imgs.removeAll()
    }
    
    func userDidTakeScreenshot() {
        // 当前屏幕的image
        let image = imageWithScreenshot()
        
        if let image = image {
            imgs.append(image)
        }
    }
    
    /// 获取当前屏幕图片
    func imageWithScreenshot() -> UIImage? {
        let imageData = dataWithScreenshotInPNGFormat()
        return UIImage(data: imageData)
    }
    
    /// 截取当前屏幕
    func dataWithScreenshotInPNGFormat() -> Data {
        var imageSize = CGSize.zero
        let screenSize = UIScreen.main.bounds.size
        let orientation = UIApplication.shared.statusBarOrientation
        if UIInterfaceOrientationIsPortrait(orientation) {
            imageSize = screenSize
        } else {
            imageSize = CGSize(width: screenSize.height, height: screenSize.width)
        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        for window in UIApplication.shared.windows {
            context?.saveGState()
            context?.translateBy(x: window.center.x, y: window.center.y)
            context?.concatenate(window.transform)
            context?.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y)
            
            if orientation == UIInterfaceOrientation.landscapeLeft {
                context?.rotate(by: CGFloat(M_PI_2))
                context?.translateBy(x: 0, y: -imageSize.width)
            } else if orientation == UIInterfaceOrientation.landscapeRight {
                context?.rotate(by: -CGFloat(M_PI_2))
                context?.translateBy(x: -imageSize.height, y: 0)
            } else if (orientation == UIInterfaceOrientation.portraitUpsideDown) {
                context?.rotate(by: CGFloat(M_PI))
                context?.translateBy(x: -imageSize.width, y: -imageSize.height)
            }
            //            if window.responds(to: #selector(UIView.drawHierarchy(_:afterScreenUpdates:))) {
            //                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            //            } else {
            //                window.layer.render(in: context!)
            //            }
            
            
            context?.restoreGState();
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIImagePNGRepresentation(image!)!
    }
    
}

extension UIView {
    func screenShot() -> UIImage{
        return screenShot(rect: bounds)
    }
    
    func screenShot(rect : CGRect) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        guard let content = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        let path = UIBezierPath(rect: rect)
        path.addClip()
        
        layer.render(in: content)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        image!.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image2!
    }
}
