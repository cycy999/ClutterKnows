//
//  WaterFlowViewHorLayout.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/4.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

protocol WaterFlowViewHorLayoutDelegate: class {
    func waterFlowViewHorLayoutDelegate(waterflowLayout: WaterFlowViewHorLayout, heightForWidth: CGFloat, indexPath: IndexPath) -> CGSize
    func getCollectionViewHeight(height: CGFloat)
}

class WaterFlowViewHorLayout: UICollectionViewLayout {

    weak var delegate: WaterFlowViewHorLayoutDelegate?
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    var maxXDict = [Int: CGFloat]()
    
    static var margin: CGFloat = 8
    
    var sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
    
    //列间距
    var columnMargin: CGFloat = margin
    
    //行间距
    var rowMargin: CGFloat = margin
    
    var maxY: CGFloat = 0
    
    //itemFrame相关参数
    var itemFrameX: CGFloat = margin //cell的x
    
    var itemFrameY: CGFloat = margin //cell的y
    
    var rowHeight: CGFloat = 20 //cell 的height
    
    var rowLeftWidth: CGFloat = margin //距离左边距的宽度
    
    override func prepare() {
        super.prepare()
        
        self.layoutAttributes.removeAll()
        maxY = 0
        let count = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0 ..< count {
            let attribute = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            self.layoutAttributes.append(attribute!)
        }
        
        maxY = self.layoutAttributes.last!.frame.maxY + sectionInset.bottom
    }
    
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: DEVICE_WIDTH, height: maxY)
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        assert(delegate != nil)
        
        let width = collectionView?.frame.size.width
        let frameSize = delegate?.waterFlowViewHorLayoutDelegate(waterflowLayout: self, heightForWidth: 0, indexPath: indexPath)

        if rowLeftWidth + frameSize!.width + rowMargin > width! {
            itemFrameX = rowMargin
            rowLeftWidth = rowMargin + frameSize!.width + rowMargin
            itemFrameY = itemFrameY + columnMargin + frameSize!.height
        } else {
            itemFrameX = rowLeftWidth
            rowLeftWidth = rowLeftWidth + frameSize!.width + rowMargin
        }
        
        let frame = CGRect(x: itemFrameX, y: itemFrameY, width: frameSize!.width, height: frameSize!.height)
        
        let layoutArr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutArr.frame = frame
        return layoutArr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
