import Foundation

func solution(_ distance:Int, _ rocks:[Int], _ n:Int) -> Int {
    let rocks = rocks.sorted()
    var answer = 1
    var start = 1
    var end = distance
    
    while(start <= end) {
        let mid = (start+end)/2
        var current = 0
        var removeCnt = 0
        
        for rock in rocks {
            if rock-current < mid {
                removeCnt += 1
                if removeCnt > n { break }
            } else {
                current = rock
            }
        }
        
        if distance - current < mid {
            removeCnt += 1
        }
        
        if removeCnt <= n {
            answer = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    
    return answer
}
