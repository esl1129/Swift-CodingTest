import Foundation

var dx = [-1,0,1,0]
var dy = [0,1,0,-1]
var min = 10000
func solution(_ board:[[Int]], _ r:Int, _ c:Int) -> Int {
    var Dict: [Int: [[Int]]] = [:]
    for i in 0..<4{
        for j in 0..<4{
            if board[i][j] != 0{
                let key = board[i][j]
                let value = [i,j]
                if Dict[key] == nil{
                    Dict[key] = [value]
                }else{
                    Dict[key]!.append(value)
                }
            }
        }
    }
    
    DFS([r,c], Dict, 0, board)
    return min+Dict.count*2
}

func DFS(_ now: [Int], _ Dict: [Int: [[Int]]], _ MoveCnt: Int, _ b: [[Int]]){
    if Dict.isEmpty{
        if MoveCnt < min{
            min = MoveCnt
        }
        return
    }
    for dic in Dict{
        let key = dic.key
        let p1 = dic.value[0]
        let p2 = dic.value[1]
        let p1MoveCnt = (getMoveCnt(now, p1, b) + getMoveCnt(p1, p2, b))
        let p2MoveCnt = (getMoveCnt(now, p2, b) + getMoveCnt(p2, p1, b))
        var reBoard = b
        reBoard[p1[0]][p1[1]] = 0
        reBoard[p2[0]][p2[1]] = 0
        let newDict = Dict.filter{$0.key != key}
        DFS(p1, newDict, MoveCnt+p2MoveCnt, reBoard)
        DFS(p2, newDict, MoveCnt+p1MoveCnt, reBoard)
    }
    return
}

func getMoveCnt(_ startLoaction: [Int], _ endLocation: [Int], _ board: [[Int]]) -> Int{
    if startLoaction == endLocation{
        return 0
    }
    var queue = [startLoaction]
    var visited = [[Bool]](repeating:[Bool](repeating: true, count: 4),count:4)
    var moveCnt = 0
    visited[startLoaction[0]][startLoaction[1]] = false
    while !queue.isEmpty{
        for _ in 0..<queue.count{
            let a = queue.removeFirst()
            for i in 0..<4{
                var newnode = [a[0]+dx[i],a[1]+dy[i]]
                if isBound(newnode) && visited[newnode[0]][newnode[1]]{
                    if newnode == endLocation{
                        return moveCnt+1
                    }
                    queue.append(newnode)
                    visited[newnode[0]][newnode[1]] = false
                }
                while true{
                    if isBound([newnode[0]+dx[i], newnode[1]+dy[i]]){
                        newnode = [newnode[0]+dx[i], newnode[1]+dy[i]]
                        if board[newnode[0]][newnode[1]] == 0{ continue }
                    }
                    break
                }
                if isBound([newnode[0], newnode[1]]) && visited[newnode[0]][newnode[1]]{
                    if newnode == endLocation{
                        return moveCnt+1
                    }
                    queue.append(newnode)
                    visited[newnode[0]][newnode[1]] = false
                }
            }
        }
        moveCnt += 1
    }
    return 0
}

func isBound(_ node: [Int]) -> Bool{
    if node[0] < 0 || node[0] > 3 || node[1] < 0 || node[1] > 3{
        return false
    }
    return true
}
