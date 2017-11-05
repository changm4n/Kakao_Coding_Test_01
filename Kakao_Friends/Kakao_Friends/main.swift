//
//  main.swift
//  Kakao_Friends
//
//  Created by changmin lee on 2017. 11. 6..
//  Copyright © 2017년 changmin. All rights reserved.
//

import Foundation


//let TESTCASE = ["CCBDE", "AAADE", "AAABF", "CCBBF"]
let TESTCASE = ["TTTANT", "RRFACC", "RRRFCC", "TRRRAA", "TTMMMF", "TMMTTJ"]

extension Array where Element == (Int,Int){
    mutating func addIndex(i:Int,j:Int){
        if !self.contains(where: {return $0.0 == i && $0.1 == j}){
            self.append((i,j))
        }
        if !self.contains(where: {return $0.0 == i+1 && $0.1 == j}){
            self.append((i+1,j))
        }
        if !self.contains(where: {return $0.0 == i && $0.1 == j+1}){
            self.append((i,j+1))
        }
        if !self.contains(where: {return $0.0 == i+1 && $0.1 == j+1}){
            self.append((i+1,j+1))
        }
    }
}

extension Array where Element == [String]{
    mutating func refresh(){
        for _ in 0..<self.count{
            for i in 0...self.count-2{
                for j in 0..<self[0].count-1{
                    if self[i+1][j] == "0"{
                        self[i+1][j] = self[i][j]
                        self[i][j] = "0"
                    }
                }
            }
        }
        self.show()
    }
    
    func show(){
        print("-----")
        for char in self{
            print(char)
        }
    }
    
}

extension String {
    var getArr:[String]{
        return  self.characters.map{String($0)}
    }
}


func solve(data:[String])->Int{
    var array:[[String]] = data.map{$0.getArr}
    var sum = 0
    
    while true {
        let tmp = getScore(arr: &array)
        
        if tmp == 0{// 더이상 제거 불가
            break
        }else{// 추가 실행
            sum += tmp
            array.refresh()
        }
    }
    return sum
    
}



func scan(data:[[String]], n:Int, m:Int)->Bool{
    let char = data[n][m]
    return char != "0" && char == data[n+1][m] && char == data[n][m+1] && char == data[n+1][m+1]
}

func getScore(arr:inout [[String]])->Int{
    
    var result:[(Int,Int)] = []
    let n = arr.count
    let m = arr[0].count
    
    for i in 0..<n-1{//스캔 후 제거가능한 Index 저장
        for j in 0..<m-1{
            if scan(data: arr, n: i, m: j){
                result.addIndex(i: i, j: j)
            }
        }
    }
    
    for index in result{//제거한 퍼즐을 0으로 변환
        arr[index.0][index.1] = "0"
    }
    
    return result.count
}

print(solve(data: TESTCASE))
