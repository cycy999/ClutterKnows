//
//  SideController.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/28.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit

class SideController: UIViewController {

    var isClosed = true
    var menuTableView: UITableView!
    var leftController: UIViewController!
    var mainController: UIViewController!
    var scalef: CGFloat = 0
    var leftLength: CGFloat = 0
    var tap: UITapGestureRecognizer!
    var pan: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leftController = LeftController()
        let nav = UINavigationController(rootViewController: ViewController())
        nav.navigationBar.barTintColor = UIColor.cyan
        mainController = MainController()
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        self.mainController.view.addGestureRecognizer(tap)
        self.mainController.view.addGestureRecognizer(pan)
        
        self.view.addSubview(self.leftController.view)
        self.view.addSubview(self.mainController.view)
        // Do any additional setup after loading the view.
    }

    @objc func handleTapGesture(_ tap: UITapGestureRecognizer) {
        closeLeftMeun()
    }
    
    @objc func handlePanGesture(_ tap: UIPanGestureRecognizer) {
        closeLeftMeun()
    }
    
    func showLeftMenu() {
        UIView.beginAnimations(nil, context: nil)
        self.mainController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.mainController.view.center = CGPoint(x: (UIScreen.main.bounds.size.width + 400) / 2, y: 20 + UIScreen.main.bounds.size.height / 2)
        UIView.commitAnimations()
        self.mainController.view.addGestureRecognizer(pan)
        self.mainController.view.addGestureRecognizer(tap)
    }
    
    func closeLeftMeun() {
        UIView.beginAnimations(nil, context: nil)
        self.mainController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.mainController.view.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        UIView.commitAnimations()
        self.mainController.view.removeGestureRecognizer(pan)
        self.mainController.view.removeGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    

}
