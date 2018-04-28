//
//  MyVerCollection.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/4.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class MyVerCollection: UIViewController {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //竖直 瀑布流的代码演示
        let flowLayout = UICollectionViewFlowLayout()
        
        let rect = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension MyVerCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor().randomColor()
        var label: UILabel?
        for v in cell.contentView.subviews {
            if v.tag == 666 {
                label = v as? UILabel
                break
            }
        }
        if label != nil {
            label?.text = "\(indexPath.item)"
        } else {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            label?.tag = 666
            cell.contentView.addSubview(label!)
            label?.text = "\(indexPath.item)"
        }
        
        return cell
    }
}
