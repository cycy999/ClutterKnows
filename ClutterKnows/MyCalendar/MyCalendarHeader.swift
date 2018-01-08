//
//  MyCalendarHeader.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/8.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

protocol MyCalendarHeaderDelegate: class {
    func myCalendarHeaderDelegate(_ tag: Int)
}

class MyCalendarHeader: UICollectionReusableView {
    
    weak var delegate: MyCalendarHeaderDelegate?
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: CGRect(x: 100, y: 0, width: DEVICE_WIDTH - 200, height: 30))
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        
        let leftButton = UIButton(frame: CGRect(x: 10, y: 0, width: 80, height: 30))
        addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        leftButton.setTitle("上个月", for: .normal)
        leftButton.setTitleColor(UIColor.black, for: .normal)
        
        let rightButton = UIButton(frame: CGRect(x: DEVICE_WIDTH - 100 + 10, y: 0, width: 80, height: 30))
        addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        rightButton.setTitle("下个月", for: .normal)
        rightButton.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func left() {
        delegate?.myCalendarHeaderDelegate(0)
    }
    
    @objc func right() {
        delegate?.myCalendarHeaderDelegate(1)
    }
}
