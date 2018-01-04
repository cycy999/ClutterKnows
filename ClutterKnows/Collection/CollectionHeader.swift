//
//  CollectionHeader.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/4.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class CollectionHeader: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel(frame: CGRect(x: 30, y: 10, width: 200, height: 20))
        titleLabel.text = "标题"
        addSubview(titleLabel)
        backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
