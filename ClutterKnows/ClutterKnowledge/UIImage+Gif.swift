//
//  UIImage+Gif.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/5/11.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func mr_animatedGifWithData(_ data: Data?) -> UIImage? {
        guard let data = data else {return nil}
        
        let source = CGImageSourceCreateWithData(data as CFData, nil)
        guard let imageSource = source else { return nil }
        let count = CGImageSourceGetCount(imageSource)
        
        if count <= 1 {
            return UIImage(data: data)
        } else {
            var images = [UIImage]()
            
            var duration: TimeInterval = 0.0
            
            for i in 0..<count {
                let image = CGImageSourceCreateImageAtIndex(imageSource, i, nil)
                
                if image == nil {
                    continue
                }
                
                duration += mr_frameDurationAtIndex(i, source: imageSource)
                
                images.append(UIImage(cgImage: image!, scale: UIScreen.main.scale, orientation: .up))
                
            }
            
            if duration == 0.0 {
                duration = (1.0 / 10.0) * Double(count)
            }
            
            return UIImage.animatedImage(with: images, duration: duration)
        }
    }
    
    fileprivate static func mr_frameDurationAtIndex(_ index: Int, source: CGImageSource) -> TimeInterval {
        var frameDuration: TimeInterval = 0.1
        
        let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        
        if let frameProperties = frameProperties as NSDictionary? {
            let gitProperties = frameProperties[kCGImagePropertyGIFDictionary as NSString]
            
            if let gitProperties = gitProperties as? NSDictionary {
                let delayTimeUnclampedProp = gitProperties[kCGImagePropertyGIFUnclampedDelayTime as NSString]
                
                if let delayTimeUnclampedProp = delayTimeUnclampedProp as? NSNumber {
                    frameDuration = delayTimeUnclampedProp.doubleValue
                } else {
                    let delayTimeProp = gitProperties[kCGImagePropertyGIFDelayTime as NSString]
                    
                    if let delayTimeProp = delayTimeProp as? NSNumber {
                        frameDuration = delayTimeProp.doubleValue
                    }
                }
                
            }
        }
        
        if frameDuration < 0.011 {
            frameDuration = 0.100
        }
        
        return frameDuration
    }
    
    static func mr_animatedGifNamed(_ name: String) -> UIImage? {
        let scale = UIScreen.main.scale
        
        if scale > 2.0 {
            let retinaPath = Bundle.main.path(forResource: name + "@3x", ofType: "gif")
            
            var data = try? Data(contentsOf: URL(fileURLWithPath: retinaPath!))
            
            if data != nil {
                return UIImage.mr_animatedGifWithData(data)
            }
            
            let path = Bundle.main.path(forResource: name, ofType: "gif")
            
            data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            if data != nil {
                return UIImage.mr_animatedGifWithData(data)
            }
            
            return UIImage(named: name)
            
        } else if scale > 1.0 {
            let retinaPath = Bundle.main.path(forResource: name + "@2x", ofType: "gif")
            
            var data = try? Data(contentsOf: URL(fileURLWithPath: retinaPath!))
            
            if data != nil {
                return UIImage.mr_animatedGifWithData(data)
            }
            
            let path = Bundle.main.path(forResource: name, ofType: "gif")
            
            data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            if data != nil {
                return UIImage.mr_animatedGifWithData(data)
            }
            
            return UIImage(named: name)
        } else {
            let path = Bundle.main.path(forResource: name, ofType: "gif")
            
            let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            if data != nil {
                return UIImage.mr_animatedGifWithData(data)
            }
            
            return UIImage(named: name)
        }
    }
    
}
