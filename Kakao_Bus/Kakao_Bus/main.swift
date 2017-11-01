//
//  main.swift
//  Kakao_Bus
//
//  Created by changmin lee on 2017. 11. 1..
//  Copyright © 2017년 changmin. All rights reserved.
//

import Foundation

print("Hello, World!")

var ntm = [[1,1,5],[2,10,2],[2,1,2],[1,1,5],[1,1,1],[10,60,45]]
var TESTCASE = [["8:0","8:1","8:2","8:3"],
                ["9:10","9:9","8:0"],
                ["9:0","9:0","9:0","9:0"],
                ["0:1","0:1","0:1","0:1","0:1"],
                ["23:59"],
                ["23:59","23:59","23:59","23:59",
                 "23:59","23:59","23:59","23:59",
                 "23:59","23:59","23:59","23:59",
                 "23:59","23:59","23:59","23:59"]
]

let answer = ["09:00","09:09","08:59","00:00","09:00","18:00"]

class KakaoTime:Comparable,Equatable{
    var min:Int
    var hour:Int
    
    init(hour:Int, min:Int) {
        self.min = min
        self.hour = hour
    }
    
    convenience init(str:String){
        let hh = Int(str.components(separatedBy: ":")[0])!
        let mm = Int(str.components(separatedBy: ":")[1])!
        self.init(hour: hh, min: mm)
    }
    
    public static func <(lhs: KakaoTime, rhs: KakaoTime) -> Bool{
        if rhs.hour > lhs.hour{
            return true
        }else if rhs.hour == lhs.hour{
            return rhs.min > lhs.min
        }else{
            return false
        }
    }
    
    public static func ==(lhs: KakaoTime, rhs: KakaoTime) -> Bool{
        if lhs.hour == rhs.hour && lhs.min == rhs.min{
            return true
        }else{
            return false
        }
        
    }
    
    public func addMin(min:Int){
        let tmp = self.min + min
        self.min = tmp%60
        self.hour += tmp/60
    }
    
    public func subMin(min:Int){
        let tmp = self.min - min
        if tmp < 0 {
            self.hour -= 1
            self.min = 60 + tmp
        }else{
            self.min = tmp
        }
    }
    
    public func toString()->String{
        return String(format: "%02d:%02d", hour,min)
    }
    
}


func solve(n:Int, t:Int, m:Int, data:[String])->String{
    
    let times = data.map { return KakaoTime(str: $0)}.sorted(by: <)
    
    var toRideIndex = 0
    let toRideTime = KakaoTime(str: "09:00")
    var rided = 0
    
    for busIndex in 1...n{
        rided = 0
        
        for index in toRideIndex..<times.count{
            
            if times[index] <= toRideTime && rided < m{
                
                rided += 1
                toRideIndex += 1
                
            }
        }
        if busIndex == n{//막차
            
            if m == rided{//막차가 넘침
                let auth = times[toRideIndex-1]
                auth.subMin(min: 1)
                return auth.toString()
            }else{//막차가 빔
                return toRideTime.toString()
            }
        }
        toRideTime.addMin(min: t)
    }
    return ""
}


for i in 0...5{
    let option = ntm[i]
    let auth = solve(n: option[0], t: option[1], m: option[2], data: TESTCASE[i])
    auth == answer[i] ? print("success"):print("fail auth:\(auth) answer:\(answer[i])")
}


