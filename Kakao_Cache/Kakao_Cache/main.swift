//
//  main.swift
//  Kakao_Cache
//
//  Created by changmin lee on 2017. 11. 1..
//  Copyright © 2017년 changmin. All rights reserved.
//

import Foundation

extension Array where Element == String{
    
    func isContain(str:String)->Bool{
        for element in self{
            if element.caseInsensitiveCompare(str) == ComparisonResult.orderedSame{
                return true
            }
        }
        return false
    }
    
    func indexOfCaseInsesitive(str:String)->Int?{
        for (index,element) in self.enumerated(){
            if element.caseInsensitiveCompare(str) == ComparisonResult.orderedSame{
                return index
            }
        }
        return nil
    }
}
let TESTCASE = [["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "Jeju", "Pangyo", "Seoul", "NewYork", "LA"],
                ["Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul"] ,
                ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"],
                ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"],
                ["Jeju", "Pangyo", "NewYork", "newyork"],
                ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"]
]



let CACHESIZE = [3,3,2,5,2,0]
let auth = [50,21,60,52,16,25]
var CACHE:[String] = []

func solve(cacheSize:Int, data:[String])->Int{
    
    var time = 0
    
    for city in data{
        
        time += getCost(cacheSize: cacheSize, city: city)
        
    }
    
    return time
}


func getCost(cacheSize:Int, city:String)->Int{
    
    var cost = 0
    if CACHE.isContain(str: city){//cache hit
        
        CACHE.remove(at: CACHE.indexOfCaseInsesitive(str: city)!)
        cost = 1
        
    }else{//cache miss
        
        if CACHE.count == cacheSize && cacheSize != 0 {CACHE.removeLast()}
        cost = 5
        
    }
    
    CACHE.insert(city, at: 0)
    return cost
}


for i in 0...5{
    let cost = solve(cacheSize: CACHESIZE[i], data: TESTCASE[i])
    let answer = auth[i]
    if answer == cost {
        print("success")
    }else{
        print("fail \(cost) answer: \(answer)")
    }
    CACHE.removeAll()
}
