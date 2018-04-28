//
//  Map_Filter_ReduceMore.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/4/3.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit



class Map_Filter_ReduceMore: NSObject {
    
    func test() {
        
        //method_1()
       
        //method_map()
        
        method_filter()
        
    }
    
    //MARK: - map
    class ModelT {
        var id = 0
        var name = ""
        init() {
            id = 5
            name = "t"
        }
    }
   
    func method_map() {
        
        let arr = [10,20,45,32]
        
        let newArr = arr.map({"\($0)?"})
        print(newArr)
        
        let newArr_2 = arr.map({money in "\(money)?"})
        print(newArr_2)
        
        let a = [ModelT(),ModelT(),ModelT(),ModelT()]
        let b = a.map({"\($0.name)yy"})
        let c = a.map({$0.id > 4})
        let d = a.map({$0.id < 4})
        print(b, c, d)
        
        /*
         ["10?", "20?", "45?", "32?"]
         ["10?", "20?", "45?", "32?"]
         ["tyy", "tyy", "tyy", "tyy"] [true, true, true, true] [false, false, false, false]
         */
    }
    
    
    //MARK: - filter & reduce
    func method_filter() {
        
        let arr = [10,20,30,40,50]
        
        let a = arr.filter({$0 > 30})
        print(a)
        
        let b = arr.reduce(0, {$0 + $1})
        let c = arr.reduce(0, +)
        
        let d = arr.reduce(1, *)
        print(b, c, d)
    }
    
    
    
    
}

extension Map_Filter_ReduceMore {
    
    func method_1() {
        print(averageOfFunction_1(a: 3, b: 4, f: square))
        
        print(averageOfFunction_1(a: 3, b: 4, f: cube))
        
        let s = averageOfFunction_1(a: 3, b: 4, f: {(x: Float) -> Float in return x * x})
        print(s)
        
        print(averageOfFunction_1(a: 3, b: 4, f: {x in return x * x}))
        
        print(averageOfFunction_1(a: 3, b: 4, f: {x in x * x}))
        
        print(averageOfFunction_1(a: 3, b: 4, f: {$0 * $0}))
    }
    
    func averageOfFunction_1(a: Float, b:Float, f:((Float) -> Float)) -> Float {
        return (f(a) + f(b)) / 2
    }
    
    func square(a: Float) -> Float {
        return a * a
    }
    
    func cube(a: Float) -> Float {
        return a * a * a
    }
    
}
