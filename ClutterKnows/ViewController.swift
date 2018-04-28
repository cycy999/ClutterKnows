//
//  ViewController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/3.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    let kScreenWidth = UIScreen.main.bounds.width
    let kScreenHeight = UIScreen.main.bounds.height
    
    let showTexts = ["基本collection","竖向瀑布流","横向瀑布流","日历","二维码","待续","待续"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushToController(_:)), name: NSNotification.Name(rawValue: "postcontroller"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "侧栏", style: .plain, target: self, action: #selector(menu))
        
        view.backgroundColor = UIColor.cyan
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64)
        tableView = UITableView(frame: rect, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ViewControllerCell.self, forCellReuseIdentifier: "ViewControllerCell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func menu() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftSide.showLeftMenu()
    }
    
    @objc func pushToController(_ notification: NSNotification) {
        print("sss")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerCell") as? ViewControllerCell
        if cell == nil {
            cell = ViewControllerCell(style: .default, reuseIdentifier: "ViewControllerCell")
        }
        cell?.textLabel?.text = showTexts[indexPath.item]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            show(CollectionController(), sender: nil)
        } else if indexPath.row == 1 {
            show(MyCollectionController(), sender: nil)
        } else if indexPath.row == 2 {
            show(HorCollectionController(), sender: nil)
        } else if indexPath.row == 3 {
            show(MyCalendarController(), sender: nil)
        } else if indexPath.row == 4 {
            show(QRCodeController(), sender: nil)
        } else if indexPath.row == 5 {
            show(ButtonsController(), sender: nil)
        } else if indexPath.row == 6 {
            //ScreenHOT.getScreenImage()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("didEndDisplaying:", cell.frame)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("willBeginEditingRowAt")
        self.view.setNeedsLayout()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let firstAction = UITableViewRowAction(style: .default, title: "测试1") { (action, index) in
            print("click on the first rowAction")
        }
        firstAction.backgroundColor = UIColor.red
        
        let secondAction = UITableViewRowAction(style: .normal, title: "测试2") { (action, index) in
            print("click on the second rowActon")
        }
        secondAction.backgroundColor = UIColor.init(patternImage: UIImage(named: "icon_delete")!)
        
        let thirdActon = UITableViewRowAction(style: .destructive, title: "测试3") { (action, index) in
            print("click on the second rowActon")
        }
        thirdActon.backgroundColor = UIColor.green
        
        return [firstAction, secondAction, thirdActon]
    }
    
    
    /*
     和iOS8-10相比，iOS11的左滑选项的视图层级有了较大改变。最显著的改变是从是UITableViewCell的子视图变成了UITableView的子视图。总结一下就是：
     
     iOS 8-10: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView -> _UITableViewCellActionButton
     iOS 11 (Xcode 8编译): UITableView -> UITableViewWrapperView -> UISwipeActionPullView -> UISwipeActionStandardButton
     iOS 11 (Xcode 9编译): UITableView -> UISwipeActionPullView -> UISwipeActionStandardButton
    
     https://www.jianshu.com/p/779f36c21632
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //uiswipeActionPullView,   uiswipeActionStandardButton,uibuttonLabel
        for subview in self.tableView.subviews {
            if subview.isKind(of: NSClassFromString("UISwipeActionPullView")!) {
                print("is have UISwipeActionPullView")
                for subsubview in subview.subviews {
                    if subsubview.isKind(of: NSClassFromString("UISwipeActionStandardButton")!) {
                        print("is have UISwipeActionStandardButton")
                        for subsubsub in subsubview.subviews {
                            if subsubsub.isKind(of: NSClassFromString("UIButtonLabel")!) {
                                print((subsubsub as? UILabel)?.text)
                                print("is have UIButtonLabel")
                                let img = UIImageView(image: UIImage(named:"icon_delete"))
                                img.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
                                subsubsub.addSubview(img)
                            }
                        }
                    }
                }
            }
        }
    }
}


