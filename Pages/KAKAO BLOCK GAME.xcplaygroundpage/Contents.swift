import Foundation

var Dict: [Int: [[Int]]] = [
    1: [[1,0],[1,1],[1,2]],
    2: [[1,0],[2,0],[2,-1]],
    3: [[1,0],[2,0],[2,1]],
    4: [[1,0],[1,-1],[1,-2]],
    5: [[1,0],[1,1],[1,-1]]
]

var DropDict: [Int: [[Int]]] = [
    1: [[0,1],[0,2]],
    2: [[0,-1],[1,-1]],
    3: [[0,1],[1,1]],
    4: [[0,-1],[0,-2]],
    5: [[0,-1],[0,1]]
]
var globalBoard: [[Int]] = []
var len: Int = 0
func solution(_ board:[[Int]]) -> Int {
    globalBoard = board
    len = board.count-1
    var i = 0
    var j = 0
    
    var answer = 0
    
    while true{
        if j > len{
            i += 1
            j = 0
        }
        if i == len && j == len{ break }
        if globalBoard[i][j] == 0 {
            j += 1
            continue
        }
        
        if totalCheck(i,j,globalBoard[i][j]){
            i = 0
            j = 0
            answer += 1
        }else{
            j += 1
        }
        
    }
    return answer
}

func removeBlock(_ index: Int, _ x: Int, _ y: Int){
    globalBoard[x][y] = 0
    for node in Dict[index]!{
        let nodeX = x+node[0]
        let nodeY = y+node[1]
        globalBoard[nodeX][nodeY] = 0
    }
}

func totalCheck(_ x: Int, _ y: Int, _ value: Int) -> Bool{
    for i in 1...5{
        if check(i,x,y,value){
            let drop = DropDict[i]!
            if dropBlack(y+drop[0][1],y+drop[1][1], x+drop[0][0], x+drop[1][0]){
                removeBlock(i,x,y)
                return true
            }
        }
    }
    return false
}

func check(_ index: Int, _ x: Int, _ y: Int, _ value: Int) -> Bool{
    for node in Dict[index]!{
        let nodeX = x+node[0]
        let nodeY = y+node[1]
        if !isBound(nodeX, nodeY){
            return false
        }
        if globalBoard[nodeX][nodeY] != value{
            return false
        }
    }
    return true
}

func isBound(_ x: Int, _ y: Int) -> Bool{
    if x < 0 || y < 0 || x > len || y > len{
        return false
    }
    return true
}

func dropBlack(_ y1: Int, _ y2: Int, _ endX1: Int, _ endX2: Int) -> Bool{
    var startX1 = 0
    var startX2 = 0
    while startX1 <= endX1{
        if globalBoard[startX1][y1] != 0{
            return false
        }
        startX1 += 1
    }
    while startX2 <= endX2{
        if globalBoard[startX2][y2] != 0{
            return false
        }
        startX2 += 1
    }
    return true
}
