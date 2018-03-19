//
//  ButtonsChosenView.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/16.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class ButtonsChosenView: UIScrollView {

    var titles = [String]() {
        didSet {
            config_buttons()
        }
    }
    
    var buttonWidth = DEVICE_WIDTH / 4
    
    var buttons = [UIButton]()
    
    var index = 0 {
        didSet {
            if titles.count <= index {
                index = 0
            }
        }
    }
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        config_buttons()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config_buttons() {
        buttons.removeAll()
        for (index, title) in titles.enumerated() {
            let button = UIButton(frame: CGRect(x: buttonWidth * CGFloat(index), y: 0, width: buttonWidth, height: 40))
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.red, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        self.contentSize = CGSize(width: buttonWidth * CGFloat(titles.count), height: 40)
    }
    
    @objc func click(_ sender: UIButton)  {
        if sender.isSelected {
            return
        }
        let tipWidth = (DEVICE_WIDTH - buttonWidth) / 2
        
        for (index,button) in buttons.enumerated() {
            if button == sender {
                button.isSelected = true
                print(sender.convert(sender.frame, to: nil))
            } else {
                button.isSelected = false
            }
        }
    }

}
