import Foundation

func solution(_ cookie:[Int]) -> Int {
    var sumCookie: [Int] = [cookie[0]]
    var answer = 0
    
    for i in 1..<cookie.count{
        sumCookie.append(sumCookie[i-1]+cookie[i])
    }
    
    for mid in 0..<cookie.count{
        var leftSum = sumCookie[mid]
        var rightSum = sumCookie[cookie.count-1]-leftSum
        var start = 0
        var end = cookie.count-1
        if leftSum < answer || rightSum < answer{
            break
        }
        while start < end{
            if leftSum > rightSum{
                leftSum-=cookie[start]
                start+=1
            }else if leftSum < rightSum{
                rightSum-=cookie[end]
                end-=1
            }else{
                if leftSum > answer{
                    answer = leftSum
                }
                break
            }
        }
    }
    return answer
}
