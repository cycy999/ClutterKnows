//
//  String-Extenstion.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit

extension String {
    // MARK:- 获取字符串的CGSize
//    func getSize(with fontSize: CGFloat) -> CGSize {
//        let str = self as NSString
//
//        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
//        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
//    }
    
    func getAttribute() {
        let font = UIFont.systemFont(ofSize: 15)
        let color = UIColor.getColor("45b173")
        
        let a = NSMutableAttributedString(string: "文本调整：")
        a.append(NSAttributedString(string: "大小", attributes: [NSAttributedStringKey.font:font]))
        
        let b = NSMutableAttributedString(string: "文本调整：")
        b.append(NSAttributedString(string: "颜色", attributes: [NSAttributedStringKey.foregroundColor : color]))
        
        let c = NSMutableAttributedString(string: "文本调整：")
        c.append(NSAttributedString(string: "大小,颜色", attributes: [
            NSAttributedStringKey.font : font,
            NSAttributedStringKey.foregroundColor : color
            ]))
        c.addAttributes([
            NSAttributedStringKey.font : font,
            NSAttributedStringKey.foregroundColor : color
            ], range: NSRange(location: 0,length: 1))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let d = NSMutableAttributedString(string: "修改", attributes: [
            NSAttributedStringKey.paragraphStyle: paragraphStyle
            ])
        d.append(NSAttributedString(string: "修改行距\n行距", attributes: [
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.font:font]))
    }
    
    //是否包含中文字符
    func isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if 0x4e00 < ch.value && ch.value < 0x9fff {
                return true
            }
        }
        return false
    }
    
    //将中文转化为拼音
    func transformToPinyin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef, nil, kCFStringTransformToLatin, false)////转化为带声调的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)////转化为不带声调
        let pinyin = stringRef as String
        let namePinyin = pinyin.replacingOccurrences(of: " ", with: "")//去除字符串之间的空格,即全拼
        print("全拼：",namePinyin)
        print(namePinyin.capitalized) //字符串首字母大写
        print(namePinyin.uppercased()) //字符串全部大写
        print(namePinyin.lowercased()) //字符串全部小写
        print(namePinyin.prefix(1)) //截取字符串首字母
        "".testString()
        return ""
    }
    
    func testString() {
        var str = "Hello, world!"
        var index = str.index(of: ",")  //得到空格在字符串中的位置
        
        //获取hello
        print(str.prefix(upTo: index!))
        print(str[..<index!])
        
        print(str.suffix(from: index!)) //, world!
        
        index = str.index(index!, offsetBy: 1) //空格位置往后移动一位
        print(str.suffix(from: index!)) // world!
        
        //删除字符串中的某部分
        let startIndex = str.index(str.startIndex, offsetBy: 1)
        let endIndex = str.index(str.startIndex, offsetBy: 3)
        str.removeSubrange(startIndex...endIndex)
        
        //替换字符串  Hnewo
        str.replacingCharacters(in: startIndex...endIndex, with: "new")

    }
}
