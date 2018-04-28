//
//  ViewControllerCell.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/4/4.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class ViewControllerCell: UITableViewCell {

    
    
    //更改cell的点击范围
    //selectedBackgroundView?.frame = CGRect(x: 12, y: 6, width: DEVICE_WIDTH - 24, height: 60)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //print("-----------layoutSubviews-----------")

        for subview in self.subviews {
            //print(subview)
            if subview.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                for button in subview.subviews {
                    if button.isKind(of: UIButton.self) {
                        (button as! UIButton).setImage(UIImage(named: "icon_delete"), for: UIControlState())
                        (button as! UIButton).setTitle(nil, for: UIControlState())
                    }
                }
            }
        }
        
    }
    
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
     //_UITableViewCellSeparatorView,UITableViewCellContentView,UITableViewCellReorderControl,UITableViewCellContentView
        for v in subviews {
            if let c = NSClassFromString("UITableViewCellReorderControl") {
                if v.isKind(of: c) {
                    var imgView: UIView?
                    for img in v.subviews {
                        if img.tag == 666 {
                            imgView = img
                        } else {
                            img.isHidden = true
                        }
                    }
                    if imgView == nil{
                        let imgView = UIImageView.newAutoLayout()
                        imgView.tag = 666
                        imgView.image = UIImage(named: "icon_drag")
                        v.addSubview(imgView)
                        imgView.autoCenterInSuperview()
                    }
                }
            }
            if let c = NSClassFromString("UITableViewCellContentView") {
                if v.isKind(of: c) {
                    if v.frame.origin.x != 0 {
                        var f = v.frame
                        f.origin.x = 0
                        v.frame = f
                    }
                }
            }
        }
    }
     */
    
    override func willTransition(to state: UITableViewCellStateMask) {
        super.willTransition(to: state)
        //print("-----------willTransition-----------")
        //return
        //当用户在某一行刚开始进行侧滑并且侧滑的Button还没有展现出来时，
        //state的值就为 UITableViewCellStateShowingDeleteConfirmationMask
        //Cell的侧滑View是懒加载
        //print(state)
        //print( UITableViewCellStateMask.showingEditControlMask.rawValue, UITableViewCellStateMask.showingDeleteConfirmationMask.rawValue)//1,2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            for v in self.subviews {
                print(v)
                if let c = NSClassFromString("UITableViewCellDeleteConfirmationView") {
                    if v.isKind(of: c) {
                        var imgView: UIView?
                        for img in v.subviews {
                            if img.tag == 666 {
                                imgView = img
                            } else {
                                img.isHidden = true
                            }
                        }
                        if imgView == nil{
                            let imgView = UIImageView()
                            imgView.tag = 666
                            imgView.image = UIImage(named: "icon_delete")
                            v.addSubview(imgView)
                            imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func didTransition(to state: UITableViewCellStateMask) {
        super.didTransition(to: state)
        //print("-----------didTransition-----------")
    }
}
