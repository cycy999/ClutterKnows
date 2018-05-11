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

        print(str.contains("cd"))//是否包含子串
        regexEmail(str: "")
    }
    
    /**
     正则表达判断是否含有结果值
     - parameter pattern: 一个字符串类型的正则表达式
     - parameter str: 需要比较判断的对象
     - returns: 返回布尔值判断结果
     - warning: 注意匹配到结果的话就会返回true，没有匹配到结果就会返回false
     */
    func regex(pattern: String, str: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [NSRegularExpression.Options.caseInsensitive])
        let resultNum = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
        if resultNum > 1 {
            return true
        }
        return false
    }
    
    //匹配有效邮箱
    func regexEmail(str: String) {
        let email = "jay734138477@qq.com"
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: email)
        print(isValid ? "正确的邮箱地址" : "错误的邮箱地址")
    }
    
    /**
     //用户名验证（允许使用小写字母、数字、下滑线、横杠，一共3~16个字符）
     ^[a-z0-9_-]{3,16}$
     
     //Email验证
     ^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$
     
     //手机号码验证
     ^1[0-9]{10}$
     
     //URL验证
     ^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$
       
     //IP地址验证
     ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$

     //html标签验证
     ^<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)$
     */
    
    //判断是否是电话号码
    func isTelNumber(num:NSString)->Bool {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true) ||
            (regextestcm.evaluate(with: num) == true) ||
            (regextestct.evaluate(with: num) == true) ||
            (regextestcu.evaluate(with: num) == true)) {
            return true
        } else {
            return false
        }
    }
    
    //Validate.email("Dousnail@@153.com").isRight//false
    //Validate.URL("https://www.baidu.com").isRight//true
    //Validate.IP("11.11.11.11").isRight//true
}

enum Validate {
    case email(String)
    case phoneNum(String)
    case carNum(String)
    case username(String)
    case password(String)
    case nickname(String)
    case URL(String)
    case IP(String)
    
    var isRight: Bool {
        var predicateStr: String!
        var currObject: String!
        switch self {
        case .email(let str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
        case .phoneNum(let str):
            predicateStr = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
            currObject = str
        case .carNum(let str):
            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
            currObject = str
        case .username(let str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currObject = str
        case .password(let str):
            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
            currObject = str
        case .nickname(let str):
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
            currObject = str
        case .URL(let str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
        case .IP(let str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
}
