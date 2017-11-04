//
//  main.swift
//  News
//
//  Created by changmin lee on 2017. 11. 4..
//  Copyright © 2017년 changmin. All rights reserved.
//

import Foundation


extension String {
    var isAlpha: Bool {
        return !isEmpty && range(of: "[^a-z]", options: .regularExpression) == nil
    }
    var getArr:[String]{
        let tmp = self.lowercased().characters.map{String($0)}
        var result:[String] = []
        for i in 0..<tmp.count-1{
            
            result.append(tmp[i...i+1].joined())
        }
        return result.filter{$0.isAlpha}.sorted()
    }
}
func getCountOf(String str:String ,inArr arr:[String])->Int{
    return arr.filter{$0 == str}.count
}

func getUnionCount(lhs:[String],Rhs:[String])->Int{
    var tmp = lhs
    var union = lhs
    
    for char in Rhs{
        if tmp.contains(char){
            tmp.remove(at: tmp.index(of: char)!)
        }else{
            union.append(char)
        }
    }
    return union.count
}

func getInterCount(lhs:[String],Rhs:[String])->Int{
    
    var count = 0
    for char in Set(lhs){
        count += min(getCountOf(String: char, inArr: Rhs), getCountOf(String: char, inArr: lhs))
    }
    return count
}

func solve(lhs:String, rhs:String)->String{
    
    let union = getUnionCount(lhs: lhs.getArr, Rhs: rhs.getArr)
    let inter = getInterCount(lhs: lhs.getArr, Rhs: rhs.getArr)
    
    if inter == 0{return "65536"}
    
    return "\(Int(Double(inter)/Double(union)*65536))"
    
}
let TESTCASE = [["FRANCE","french"],
                ["handshake","shake hands"],
                ["aa1+aa2","AAAA12"],
                ["E=M*C^2","e=m*c^2"]]

let auth = ["16384","65536","43690","65536"]


for (index,test) in TESTCASE.enumerated(){
    var result = ""
    let answer = solve(lhs: test[0], rhs: test[1])
    if answer == auth[index]{
        result = "success"
    }else{
        result = "fail"
    }
    print("||\(result)|| answer \(answer) || auth \(auth[index])")
}
