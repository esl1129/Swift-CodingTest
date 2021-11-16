import Foundation

func solution(_ n:Int) -> Int {
    if n < 4{ return n == 1 ? 1 : 0 }
    
    var chessArr = [Int](repeating: -1, count: n)
    var answer = 0
    for i in 0..<chessArr.count{
        var newChess = chessArr
        newChess[0] = i
        answer += DFS(newChess, 1)
    }
    
    return answer
}
func DFS(_ chess: [Int], _ depth: Int) -> Int{
    if depth >= chess.count{
        return 1
    }
    var answer = 0
    for i in 0..<chess.count{
        if !chess.contains(i){
            var check = true
            for j in 1...depth{
                if i-j >= 0{
                    if chess[depth-j] == i-j {
                        check = false
                        break
                    }
                }
                if chess[depth-j] == i+j{
                    check = false
                    break
                }
            }
            if check{
                var newChess = chess
                newChess[depth] = i
                answer += DFS(newChess, depth + 1)
            }
        }
    }
    return answer
}
