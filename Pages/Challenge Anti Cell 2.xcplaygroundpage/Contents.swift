import Foundation
let MOD = 1000000007
func solution(_ a:[Int], _ s:[Int]) -> [Int] {
    var powDict: [Int:Int] = [:]
    var sqrtDict: [Int:Int] = [:]
    var num = 1
    for i in 0..<50{
        powDict[num] = i
        sqrtDict[i] = num
        num *= 2
    }
    var answer: [Int] = []
    var now = 0
    var DP: [[Int]] = []
    for range in s{
        if range == 1{
            answer.append(1)
            now += range
            continue
        }
        let b = Array(a[now..<now+range])
        // Prefix Sum
        var psBySum: [Int:Int] = [:]
        var psByIdx: [Int:Int] = [:]
        var num = 0
        for w in 0..<range{
            num += b[w]
            psBySum[num] = w
            psByIdx[w] = num
        }
        
        // Sample for DP
        let col = Int(log2(Double(num)))+1
        // DP[i][e] == b[i]*2^e
        DP = [[Int]](repeating: [Int](repeating: 0, count: col), count: range)
        DP[0][0] = 1
        for i in 1..<range{
            DP[i][0] = (DP[i-1].map{$0%MOD}.reduce(0,+))%MOD
            let PSI = psByIdx[i]!
            for e in 1..<col{
                let BI = b[i]*sqrtDict[e-1]!
                let PSH = PSI-BI
                if PSH <= 0 { break }
                guard let half = psBySum[PSH] else { break }
                if BI % b[half] != 0 { break }
                let value = BI/b[half]
                if value < 1 { break }
                guard let ep = powDict[value] else { break }
                if ep >= col || DP[half][ep] == 0 { break }
                let PSF = PSI-BI*2
                if PSF < 0 { break }
                if PSF == 0{
                    DP[i][e] = 1
                    continue
                }
                guard let full = psBySum[PSF] else { break }
                DP[i][e] = (DP[full].reduce(0,+))%MOD
            }
        }
        answer.append(DP.last!.map{$0%MOD}.reduce(0,+)%MOD)
        now += range
    }
    return answer
}
