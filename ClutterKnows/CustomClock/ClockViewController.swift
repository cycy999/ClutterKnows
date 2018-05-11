//
//  ClockViewController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/5/6.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit
import PureLayout

@objcMembers
class ClockViewController: UIViewController {

    //计时器
    var timer: Timer!
    
    //时针，分针，秒针
    var hourView: UIView!
    var hourLength: CGFloat = 50
    
    var minuteView: UIView!
    var minuteLength: CGFloat = 65
    
    var secondView: UIView!
    var secondLength: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "代码实现时钟效果"
        
        makeUI()
        makeTimer()
        
        view.backgroundColor = UIColor.white
    }
}

extension ClockViewController {
    //1.创建时针，分针，秒针
    func makeUI() {
        hourView = UIView()
        hourView.center = self.view.center
        hourView.layer.bounds = CGRect(x: 0, y: 0, width: 2, height: hourLength)
        hourView.backgroundColor = UIColor.black
        hourView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        hourView.layer.cornerRadius = 1
        view.addSubview(hourView)
        
        minuteView = UIView()
        minuteView.center = self.view.center
        minuteView.layer.bounds = CGRect(x: 0, y: 0, width: 1.5, height: minuteLength)
        minuteView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        minuteView.backgroundColor = UIColor.blue
        view.addSubview(minuteView)
        
        secondView = UIView()
        secondView.center = self.view.center
        secondView.layer.bounds = CGRect(x: 0, y: 0, width: 1, height: secondLength)
        secondView.backgroundColor = UIColor.cyan
        secondView.layer.anchorPoint = CGPoint(x: 1, y: 0.7)//此处系数为相应宽高的倍数
        view.addSubview(secondView)
    }
    
}

extension ClockViewController {
    //创建计时器
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2,target:self,selector:#selector(move),userInfo:nil,repeats:true)

    }
    //3.改变指针位置
    func move() {
        var angleSecond: CGFloat = CGFloat(Double.pi * 2 / 60)
        var angleMinute: CGFloat = CGFloat(Double.pi * 2 / 60)
        var angleHour: CGFloat = CGFloat(Double.pi * 2 / 12)
        
        //当前时间
        let date = Date()
        let calendar = Calendar.current
        let secondInt = CGFloat(calendar.component(.second, from: date))
        let minuteInt = CGFloat(calendar.component(.minute, from: date))
        let hourInt = CGFloat(calendar.component(.hour, from: date))
        
        //旋转角度
        angleSecond = angleSecond * secondInt
        angleMinute = angleMinute * minuteInt + angleSecond / 60
        angleHour = angleHour * hourInt + angleMinute / 60
        
        //保持中心点
        secondView.center = self.view.center
        minuteView.center = self.view.center
        hourView.center = self.view.center
        
        //旋转各自的角度
        self.secondView.transform = CGAffineTransform(rotationAngle: angleSecond)
        self.minuteView.transform = CGAffineTransform(rotationAngle: angleMinute)
        self.hourView.transform = CGAffineTransform(rotationAngle: angleHour)
    }
    
    //4.手机旋转后的页面刷新
    //增加在旋转模式下的自动刷新，帮助修正显示。
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        move()
    }
}
