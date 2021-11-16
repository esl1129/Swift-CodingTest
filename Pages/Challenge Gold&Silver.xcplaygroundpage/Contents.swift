import Foundation

func solution(_ a:Int, _ b:Int, _ g:[Int], _ s:[Int], _ w:[Int], _ t:[Int]) -> Int64 {
    let size = g.count
    func search(_ mid: Int64) -> Bool{
        var maxGold = 0
        var maxSilver = 0
        var maxTotal = 0
        for i in 0..<size{
            let time = t[i]
            let roundTime = time*2
            var move_cnt = Int(mid/Int64(roundTime))
            if Int(mid % Int64(roundTime)) >= time{
                move_cnt += 1
            }
            let now = w[i]*move_cnt
            maxGold += g[i] < now ? g[i] : now
            maxSilver += s[i] < now ? s[i] : now
            maxTotal += g[i]+s[i] < now ? g[i]+s[i] : now
        }
        return maxGold >= a && maxSilver >= b && maxTotal >= a+b
    }
    
    var answer:Int64 = -1
    var start:Int64 = 0
    var end:Int64 = Int64(10e14*3)
    answer = end
    while start <= end{
        let mid = (start + end)/2
        if search(mid){
            answer = answer < mid ? answer : mid
            end = mid - 1
        }else{
            start = mid + 1
        }
    }
    return answer
}
