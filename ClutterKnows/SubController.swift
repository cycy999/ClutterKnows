//
//  SubController.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/28.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit

class SubController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "hahaha"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menu))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func menu() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftSide.showLeftMenu()
    }

}
