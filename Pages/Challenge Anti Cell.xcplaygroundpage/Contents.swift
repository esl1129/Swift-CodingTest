import Foundation


func solution(_ a:[Int], _ s:[Int]) -> [Int] {
    func search(_ sum: [Int64],_ ri: Int){
        let size = sum.count
        if size > 1{
            if sum[size-2] == sum[size-1]{
                globNow += 1
                search(Array(sum[0..<size-2])+[sum[size-1]+sum[size-2]], ri)
            }
        }
        if ri < globDep{
            search(sum+[Int64(a[now+ri+1])], ri+1)
        }
        return
    }
    var globNow = 1
    var globDep = 0
    var answer: [Int] = []
    var now = 0
    for range in s{
        if range == 1{
            answer.append(1)
            now += range
            continue
        }
        globDep = range-1
        search([Int64(a[now]),Int64(a[now+1])],1)
        now += range
        answer.append(globNow % 1000000007)
        globNow = 1
    }
    
    return answer
}

