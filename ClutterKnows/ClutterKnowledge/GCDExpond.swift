//
//  GCDExpond.swift
//  SideVCApp
//
//  Created by 陈岩 on 2018/1/2.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class GCDExpond: NSObject {

    //GCD有六个优先级，background，utility，default，userInitiated，userInteractive
    //userInteractive>default>unspecified>userInitiated>utility>background
    //GCD编程的核心就是调度队列（dispatch queue）。dispatch queue是一个FIFO（先进先出）的队列，它保证了GCD任务按照FIFO的顺序执行，即第一个添加到dispatch queue中的任务，第一个执行，第二个添加到dispatch queue中的任务第二个执行，如此直到终点。所有的dispatch queue都是线程安全的，你能从多个线程中并行的访问他们。
    
    //http://blog.csdn.net/Hello_Hwc/article/details/54293280
    
    
    func getMain() {
        
        //主队列/全局队列获取
        let  mainQueue = DispatchQueue.main
        let globalQueue = DispatchQueue.global()
        let globalQueueWithQos = DispatchQueue.global(qos: .userInitiated)
        print(mainQueue, globalQueue, globalQueueWithQos)

        //主队列
        DispatchQueue.main.async {
            
        }
        
        DispatchTimer(timeInterval: 0.1, repeatCount: 5) { (timer, count) in
            print("剩余次数：\(count)")
        }
        
        DispatchTimer(timerInterval: 3) { (timer) in
            print("循环")
        }
        DispatchAfter(after: 4) {
            print("延时打印")
        }
        
        //延迟操作时间
        let delay_0 = DispatchTime.now() + Double(Int64(0.25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            //延迟操作内容
        })
        
    }
    
    
    
    /// GCD定时器倒计时⏳
    ///   - timeInterval: 循环间隔时间
    ///   - repeatCount: 重复次数
    ///   - handler: 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
    func DispatchTimer(timeInterval: Double, repeatCount: Int, handler: @escaping(DispatchSourceTimer?, Int) -> ()) {
        if repeatCount <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 {
                timer.cancel()
            }
        }
    }
    
    func DispatchTimer(timerInterval: Double, handler: @escaping (DispatchSourceTimer?) -> ()) {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: timerInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                handler(timer)
            }
        }
        timer.resume()
    }
    
    /// GCD延时操作
    ///   - after: 延迟的时间
    ///   - handler: 事件
    func DispatchAfter(after: Double, handler:@escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
    
    func gcdTest() {
        for i in 1...10 {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                NSLog("DispatchQoS.QoSClass.default, %d", i)
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                NSLog("DispatchQoS.QoSClass.background, %d", i)
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.unspecified).async {
                NSLog("DispatchQoS.QoSClass.unspecified, %d", i)
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                NSLog("DispatchQoS.QoSClass.userInitiated, %d", i)
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
                NSLog("DispatchQoS.QoSClass.userInteractive, %d", i)
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
                NSLog("DispatchQoS.QoSClass.utility, %d", i)
            }
        }
    }
}

extension GCDExpond {
    
    //GCD使用步骤：1.创建队列（串行或并发）；2.将任务添加到队列的等待队列中，系统根据任务类型执行（同步或异步）
    //1.同步执行 + 并发队列
    //2.异步执行 + 并发队列
    //3.同步执行 + 串发队列
    //4.异步执行 + 串发队列

    func test() {
        
    }
    
    
    func syncConcurrent() {
        print()
        print("syncConcurrent---begin")
        let queue = DispatchQueue(label: "com")
    }
    
    
}
