//
//  LockViewController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/5/7.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {

    class Person {
        var name: String
        var age: Int
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        func update(name: String, delay: Int, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    var person = Person(name: "leo", age: 23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension LockViewController {
    func addLock() {
        //互斥锁
        objc_sync_enter(self)
        //需要执行的代码块
        objc_sync_exit(self)
        

    }
    
    //MJRefresh 动态刷新图
    func refreshTableView() {
//        let refreshImage = UIImage.mr_animatedGifNamed("refresh")
//
//        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
//        header?.setImages([refreshImage!], for: .idle)
//        header?.setImages([refreshImage!], for: .pulling)
//        header?.setImages([refreshImage!], for: .refreshing)
//        header?.lastUpdatedTimeLabel.isHidden = true
//        header?.stateLabel.isHidden = true
//        header?.mj_h = 120
//        tableView.mj_header = header
        
    }
    
    
}
