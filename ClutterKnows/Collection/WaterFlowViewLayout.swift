//
//  WaterFlowViewLayout.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/4.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

//参考http://blog.csdn.net/yi_zz32/article/details/50520136


protocol WaterFlowViewLayoutDelegate: class {
    ///height是瀑布流每个item的长度
    func waterFlowViewLayout(waterFlowViewLayout: WaterFlowViewLayout, heightForWidth: CGFloat, atIndexPaht: IndexPath) -> CGFloat
}

class WaterFlowViewLayout: UICollectionViewLayout {

    weak var delegate: WaterFlowViewLayoutDelegate?
    
    //所有cell的布局属性
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    ///使用一个字典记录每列的最大Y值
    var maxYDict = [Int: CGFloat]()
    
    static var margin: CGFloat = 8
    
    ///瀑布流四周的间距
    var sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    
    //列间距
    var columnMargin: CGFloat = margin
    
    //行间距
    var rowMargin: CGFloat = margin
    
    ///瀑布流列数
    var colum = 4
    
    var maxY: CGFloat = 0
    
    var columnWidth: CGFloat = 0
    
    //prepareLayout会在调用collectionView.reloadData()
    //做出整体的布局设置
    override func prepare() {
        super.prepare()
        //设置布局
        //需要清空字典里面的值
        for key in 0 ..< colum {
            maxYDict[key] = 0
        }
        
        //清空之前的布局属性
        layoutAttributes.removeAll()
        
        //清空最大列的Y值
        maxY = 0
        
        ///清空列宽
        columnWidth = 0
        
        //计算每列的宽度，需要在布局之前算好
        columnWidth = (DEVICE_WIDTH - sectionInset.left - sectionInset.right - (CGFloat(colum) - 1) * columnMargin) / CGFloat(colum)
        
        let number = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        for i in 0 ..< number {
            //布局每一个cell的frame
            let layoutAttr = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            layoutAttributes.append(layoutAttr!)
        }
        
        calcMaxY()
    }
    
    
    func calcMaxY() {
        //获取最大这一列的Y
        //默认第0列最长
        var maxYCoulum = 0
        //for 循环比较，获取最长的这列
        for (key, value) in maxYDict {
            if value > maxYDict[maxYCoulum]! {
                maxYCoulum = key
            }
        }
        //获取到Y值最大的这一列
        maxY = maxYDict[maxYCoulum]! + sectionInset.bottom
    }
    
    //返回collectionViewContentSize 大小
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: DEVICE_WIDTH, height: maxY)
        }
        
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    // 返回每一个cell的布局属性(layoutAttributes)
    //  UICollectionViewLayoutAttributes: 1.cell的frame 2.indexPath
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        assert(delegate != nil) //"瀑布流必须实现代理来返回cell的高度")
        
        let height = delegate?.waterFlowViewLayout(waterFlowViewLayout: self, heightForWidth: columnWidth, atIndexPaht: indexPath)
        
        // 找到最短的那一列,去maxYDict字典中找
        
        // 最短的这一列
        var minYColumn = 0
        
        for (key, value) in maxYDict {
            if value < maxYDict[minYColumn]! {
                minYColumn = key
            }
        }
        // minYColumn 就是短的那一列
        let x = sectionInset.left + CGFloat(minYColumn) * (columnWidth + columnMargin)
        
        //最短这列的Y值 + 行间距
        let y = maxYDict[minYColumn]! + rowMargin
        
        //设置cell的frame
        let frame = CGRect(x: x, y: y, width: columnWidth, height: height!)
        
        //更新最短这列的最大Y值
        maxYDict[minYColumn] = frame.maxY
        
        //创建每个cell对应的布局属性
        let layoutAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        layoutAttr.frame = frame
        
        return layoutAttr
    }
    
    //预加载下一页数据
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
