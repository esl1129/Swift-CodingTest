import Foundation

// you can write to stdout for debugging purposes, e.g.
// print("this is a debug message")

public func solution(_ A : inout [Int], _ K : Int) -> Int {
    if A.count < K{
        return -1
    }
    var dp = [-1,-1]
    var evenArr = A.filter{$0 % 2 == 0}.sorted{$0 > $1}
    var noEvenArr = A.filter{$0 % 2 == 1}.sorted{$0 > $1}
    if evenArr.isEmpty{
        return -1
    }
    let evenCnt = evenArr.count
    for i in 1..<evenCnt{
        evenArr[i] += evenArr[i-1]
    }
    let noEvenCnt = noEvenArr.count
    for i in 1..<noEvenCnt{
        noEvenArr[i] += noEvenArr[i-1]
    }
    var max = -1
    var eIdx = K % 2 == 0 ? 0 : 1
    var nIdx = K % 2 == 0 ? K : K-1
    while nIdx >= 0{
        if nIdx > noEvenCnt || eIdx > evenCnt{
            eIdx += 2
            nIdx -= 2
            continue
        }
        let evenSum = eIdx > 0 ? evenArr[eIdx-1] : 0
        let noEvenSum = nIdx > 0 ? noEvenArr[nIdx-1] : 0
        max = max > evenSum + noEvenSum ? max : evenSum + noEvenSum
        eIdx += 2
        nIdx -= 2
    }
    return max
    // write your code in Swift 4.2.1 (Linux)
}
