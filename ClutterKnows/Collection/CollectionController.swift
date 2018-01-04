//
//  CollectionController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/3.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config_collectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CollectionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func config_collectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.itemSize = CGSize(width: (DEVICE_WIDTH - 20) / 2, height: 100)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        flowLayout.headerReferenceSize = CGSize(width: DEVICE_HEIGHT, height: 40)
        flowLayout.footerReferenceSize = CGSize(width: DEVICE_WIDTH, height: 20)
        
        let rect = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(CollectionFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
        
    //返回区头、区尾实例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.cyan
        cell.contentView.backgroundColor = UIColor.cyan
        return cell
    }
    
    // 长按某item，弹出copy和paste的菜单
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 使copy和paste有效
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if NSStringFromSelector(action) == "copy" {
            print("it is copy")
            return true
        } else if NSStringFromSelector(action) == "paste:" {
            print("it is paste")
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if NSStringFromSelector(action) == "copy" {
            print("it is copyed")
            collectionView.performBatchUpdates({
                
            }, completion: { (_) in
                
            })
        } else if NSStringFromSelector(action) == "paste:" {
            print("it is pasted")
        }
    }
    
    //如果以下数据是固定值，可通过 flowLayout 设置
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 //flowLayout.minimumLineSpacing = 4
    }
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 //flowLayout.minimumInteritemSpacing = 6
    }
    
    //item尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (DEVICE_WIDTH - 20) / 2, height: 100)
        //flowLayout.itemSize = CGSize(width: (DEVICE_WIDTH - 20) / 2, height: 100)
    }
    
    //每组分区区头size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: DEVICE_HEIGHT, height: 40)
        //flowLayout.headerReferenceSize = CGSize(width: DEVICE_HEIGHT, height: 40)
    }
    
    //每组分区区尾size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: DEVICE_WIDTH, height: 30)
        //flowLayout.footerReferenceSize = CGSize(width: DEVICE_WIDTH, height: 20)
    }
    
    //每个分区的内边距:每组 items 距离区头、区尾 及左右两边的距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5) //flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    //参考http://blog.csdn.net/a44496913/article/details/54236073
    //https://www.jianshu.com/p/16c9d466f88c
    //https://www.jianshu.com/p/cf616f73d596
    
}
