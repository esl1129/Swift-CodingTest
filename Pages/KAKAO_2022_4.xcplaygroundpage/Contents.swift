import Foundation

func solution(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    let ROW = board.count
    let COL = board[0].count
    var dp = [[Int]](repeating: [Int](repeating: 0, count: COL+1), count: ROW+1)
    
    for skill in skill {
        let n = skill[0] == 1 ? -skill[5] : skill[5]
        dp[skill[1]][skill[2]] += n
        dp[skill[1]][skill[4]+1] += -n
        dp[skill[3]+1][skill[2]] += -n
        dp[skill[3]+1][skill[4]+1] += n
    }
    
    for i in 0..<ROW{
        for j in 1..<COL{
            dp[i][j] += dp[i][j-1]
        }
    }
    
    for i in 0..<COL{
        for j in 1..<ROW{
            dp[j][i] += dp[j-1][i]
        }
    }
    
    for i in 0..<ROW{
        for j in 0..<COL{
            dp[i][j] += board[i][j]
        }
    }
    var ans = 0
    for i in 0..<ROW{
        for j in 0..<COL{
            if dp[i][j] > 0 {
                ans += 1
            }
        }
    }
    return ans
}
