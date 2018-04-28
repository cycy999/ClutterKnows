//
//  ButtonsController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/16.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class ButtonsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsChosenView = ButtonsChosenView(frame: CGRect(x: 0, y: 100, width: DEVICE_WIDTH, height: 40), titles: ["测试1","测试2","测试3","测试4","测试5","测试6","测试7"])
        
        view.addSubview(buttonsChosenView)
        view.backgroundColor = UIColor.white
        buttonsChosenView.backgroundColor = UIColor.viewBackGroundColor()
        print(buttonsChosenView.contentSize)
        print(buttonsChosenView.contentOffset)
        buttonsChosenView.contentSize = CGSize(width: DEVICE_WIDTH * 2, height: 40)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
