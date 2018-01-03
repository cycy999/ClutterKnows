//
//  MainController.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/28.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushToController(_:)), name: NSNotification.Name(rawValue: "postcontroller"), object: nil)
        
        var vcs = [UINavigationController]()
        for color in [UIColor.white, UIColor.yellow,UIColor.red] {
            let viewController = SubController()
            viewController.view.backgroundColor = color
            viewController.title = "子页面"
            viewController.tabBarItem = UITabBarItem(title: "测试", image: nil, selectedImage: nil)
            viewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.black], for: .normal)
            viewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.red], for: .selected)
            viewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
            let nav = UINavigationController(rootViewController: viewController)
            nav.view.backgroundColor = UIColor.white
            nav.navigationBar.barStyle = .black
            vcs.append(nav)
        }
        viewControllers = vcs
        
        
        // Do any additional setup after loading the view.
    }
    
    func menu() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftSide.showLeftMenu()
    }
    
    @objc func pushToController(_ notification: NSNotification) {
        self.selectedIndex = 1
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
