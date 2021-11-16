import Foundation


func solution(_ land:[[Int]], _ p:Int, _ q:Int) -> Int64 {
    var dict: [Int: Int] = [:]
    var totalSum = 0
    for la in land{
        for l in la{
            if dict[l] == nil{
                dict[l] = 1
            }else{
                dict[l]! += 1
            }
            totalSum += l
        }
    }
    totalSum *= q
    let sort = dict.sorted{$0.key < $1.key}
    var leftLength = 0
    var rightLength = land.count*land[0].count
    var beforeFloor = 0
    for s in sort{
        let step = s.key - beforeFloor
        let a = totalSum + step*leftLength*p - rightLength*step*q
        if a > totalSum{ // 변곡점
            break
        }
        totalSum = a
        beforeFloor = s.key
        rightLength -= s.value
        leftLength += s.value
    }
    
    return Int64(totalSum)
}
