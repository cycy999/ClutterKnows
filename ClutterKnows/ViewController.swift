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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "测试\(indexPath.row)"
        return cell!
    }


}
