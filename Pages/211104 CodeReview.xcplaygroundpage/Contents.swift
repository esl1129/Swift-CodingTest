import Foundation

var totalMax = 0
var maxArr:[Int] = [0,0,0,0]
func solution(_ land:[[Int]]) -> Int{
    maxArr = land[0]
    for i in 1..<land.count{
        var l = land[i]
        var nowArr = maxArr
        for j in 0..<4{
            maxArr[j] = getMax(nowArr: nowArr,arr: l, index: j)
        }
    }
    
    var max = 0
    for k in 0..<4{
        if maxArr[k] > max {
            max = maxArr[k]
        }
    }
    return max
}

func getMax(nowArr: [Int],arr: [Int], index: Int) -> Int{
    var max = 0
    for i in 0..<4{
        if nowArr[i] > max && i != index{
            max = nowArr[i]
        }
    }
    return arr[index] + max
}
