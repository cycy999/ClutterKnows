//
//  LeftController.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/28.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit

class LeftController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let kScreenWidth = UIScreen.main.bounds.width
    let kScreenHeight = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "left侧边栏"
        view.backgroundColor = UIColor.red
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "postcontroller"), object: indexPath.row)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.leftSide.closeLeftMeun()
    }
}
