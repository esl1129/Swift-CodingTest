import Foundation

func solution(_ input_array:[String]) -> Int{
    var totalDp: [Int] = [0,0]
    var sum = 0
    var pivot = input_array.count-1
    while pivot >= 0{
        if input_array[pivot] != "+"{
            if input_array[pivot] == "-"{
                let tmp = totalDp
                totalDp[0] = getMin(-tmp[1],tmp[0])
                totalDp[0] -= sum
                totalDp[1] = getMax(-(tmp[0]+sum),tmp[1]+sum-(2*Int(input_array[pivot+1])!))
                sum = 0
            }else{
                sum += Int(input_array[pivot])!
            }
        }
        pivot -= 1
    }
    return totalDp[1]+sum
}

func getMin(_ a: Int, _ b: Int) -> Int{
    return a < b ? a : b
}

func getMax(_ a: Int, _ b: Int) -> Int{
    return a > b ? a : b
}
