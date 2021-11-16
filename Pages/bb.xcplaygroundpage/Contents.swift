import Foundation

// you can write to stdout for debugging purposes, e.g.
// print("this is a debug message")

public func solution(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var roomCnt = 0
    A = A.sorted{$0 < $1}
    var currentMax = 0
    var currentCnt = 0
    for a in A{
        if a >= currentMax && currentMax > currentCnt{
            currentCnt += 1
            continue
        }
        currentMax = a
        currentCnt = 1
        roomCnt += 1
    }
    
    return roomCnt
}
