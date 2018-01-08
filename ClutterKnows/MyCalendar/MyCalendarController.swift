//
//  MyCalendarController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/7.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class MyCalendarController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var calendarControl = MyCalendarControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarControl.refreshDate()
        
        config_collectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension MyCalendarController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func config_collectionView() {
        let rect = CGRect(x: 0, y: 64, width: DEVICE_WIDTH, height: DEVICE_HEIGHT - 64)
        let width = (DEVICE_WIDTH - 5 * 2 - 5 * 6) / 7
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: width, height: 50)
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        layout.headerReferenceSize = CGSize(width: DEVICE_WIDTH, height: 30)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCalendarCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MyCalendarHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCalendarHeader")
        collectionView.backgroundColor = UIColorExpand.viewBackGroundColor()
        view.addSubview(collectionView)
    }
    
    //显示所展示月信息
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCalendarHeader", for: indexPath) as! MyCalendarHeader
        header.titleLabel.text = "\(calendarControl.currentMonth.year!)-\(calendarControl.currentMonth.month!)"
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarControl.calendarModels.count//daysOfMonth(date: date) + dayWeekOfMonth(date: firstDayDateOfMonth()) + 6 - dayWeekOfMonth(date: lastDayOfMonth(date: date)!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCalendarCollectionCell
        let row = calendarControl.calendarModels[indexPath.item]
        cell.titleLabel.text = "\(row.day!)\n\(row.month!)月"
        if row.month == calendarControl.currentMonth.month {
            cell.contentView.backgroundColor = UIColor.cyan
            if row.day == calendarControl.todayDate.day
                && row.month == calendarControl.todayDate.month
                && row.year == calendarControl.todayDate.year {
                cell.titleLabel.textColor = UIColor.red
            } else {
                cell.titleLabel.textColor = UIColor.black
            }
        } else {
            cell.contentView.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let row = calendarControl.calendarModels[indexPath.row]
        let date = calendarControl.calendar.date(from: row)
        print(date as Any)
    }
}

extension MyCalendarController: MyCalendarHeaderDelegate {
    //上月，下月
    func myCalendarHeaderDelegate(_ tag: Int) {
        if tag == 0 {
            calendarControl.jumpMonth = -1
            collectionView.reloadData()
        } else {
            calendarControl.jumpMonth = 1
            collectionView.reloadData()
        }
    }
    
}
