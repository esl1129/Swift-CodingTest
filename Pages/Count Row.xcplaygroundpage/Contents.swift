import Foundation

let MOD = 10000019
var combis: [[Int]] = []
func solution(_ a:[[Int]]) -> Int {
    // 선언부
    let row = a.count
    let col = a[0].count
    var numOfOne = [Int](repeating: 0, count: col)
    var combis = [[Int]](repeating: [Int](repeating: 0, count: row+1), count: row+1)
    var DP = [[Int]](repeating: [Int](repeating: 0, count: row+1), count: col+1)
    
    // combis
    combis[0][0] = 1
    for i in 1...row{
        for j in 0...i{
            if j == 0 || i == j{
                combis[i][j] = 1
            }else{
                combis[i][j] = (combis[i-1][j-1] + combis[i-1][j])%MOD
            }
        }
    }
    
    // numOfOne
    for i in 0..<row{
        for j in 0..<col{
        if a[i][j] == 1 {
          numOfOne[j] += 1
        }
      }
    }
    
    
    DP[1][row-numOfOne[0]] = combis[row][row-numOfOne[0]]
    for curCol in 1..<col{
        for curRow in 0...row{
            if DP[curCol][curRow] == 0 { continue }
            for one in 0...numOfOne[curCol]{
                // curRow행 중에 one개 선택 + 열의1개수 - one개
                let next = (curRow-one)+(numOfOne[curCol]-one)
                if next > row || curRow < one { continue }
                let cases = (combis[curRow][one] * combis[row-curRow][numOfOne[curCol]-one])%MOD
                DP[curCol+1][next] += (DP[curCol][curRow] * cases)%MOD
            }
        }
    }
    return DP[col][row]
    
}
