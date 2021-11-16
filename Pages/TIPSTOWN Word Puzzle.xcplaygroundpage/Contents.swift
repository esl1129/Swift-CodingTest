import Foundation

func solution(_ strs:[String], _ t:String) -> Int{
    let size = t.count
    var dp = [Int](repeating: -1, count: size+1)
    dp[0] = 0
    let strArr = t.map{String($0)}
    var puzzleDict = [String: Set<String>]()
    for s in strs{
        let p = String(s.last!)
        if puzzleDict[p] == nil{
            puzzleDict[p] = [s]
        }else{
            puzzleDict[p]!.insert(s)
        }
        
    }
    for next in 1...size{
        let key = strArr[next-1]
        if puzzleDict[key] == nil{ continue }
        for range in 1...5{
            let prev = next-range
            if prev < 0{ break }
            if dp[prev] == -1 { continue }
            if puzzleDict[key]!.contains(strArr[prev..<next].joined(separator:"")){
                let now = dp[prev]+1
                if dp[next] == -1 || now < dp[next] {
                    dp[next] = now
                }
            }
        }
    }
    
    return dp.removeLast()
}
