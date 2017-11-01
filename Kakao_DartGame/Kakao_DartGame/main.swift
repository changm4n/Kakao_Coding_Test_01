//
//  main.swift
//  Kakao_DartGame
//
//  Created by changmin lee on 2017. 10. 31..
//  Copyright © 2017년 changmin. All rights reserved.
//

import Foundation


let TESTCASE = ["1S2D*3T","1D2S#10S","1D2S0T","1S*2T*3S","1D#2S*3S","1T2D3D#","1D2S3T*"]

func calcOptions(point:Int, option:String)->Int{
    var result = point
    switch option {
    case "D":
        result = point*point
    case "T":
        result = point*point*point
    default:
        result = point
    }
    return result
}


func calculate(str:[String])->Int{
    
    var points:[Int] = [0,0,0]
    for (index,score) in str.enumerated(){
        
        let point = Int(score.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())!
        let options = score.substring(from: score.index(score.startIndex, offsetBy: String(point).characters.count))
        
        points[index] = calcOptions(point: point, option:String(options.characters.first!))
        
        if options.characters.count == 2{
            let option2 = options.characters.last!
            if option2 == "*"{
                if index > 0{points[index-1] *= 2}
                points[index] *= 2
            }else{
                points[index] *= -1
            }
        }
        
    }
    return points.reduce(0){$0+$1}
    
}



func parse(str:String)->[String]{
    let regex = try! NSRegularExpression(pattern: "([0-9]|10)([SDT])([*#]?)", options:.caseInsensitive)
    let matches = regex.matches(in: str, options: .reportCompletion, range: NSMakeRange(0, str.characters.count) )
    let result = matches.map{
        return (str as NSString).substring(with: $0.rangeAt(0))
    }
    return result
}

for test in TESTCASE{
    let line = parse(str:test)
    print(calculate(str:line))
    
}
