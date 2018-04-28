//
//  MyCalendarCollectionCell.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/7.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class MyCalendarCollectionCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.fontGreenColor()
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
