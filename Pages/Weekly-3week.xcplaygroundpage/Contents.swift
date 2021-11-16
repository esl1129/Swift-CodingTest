import Foundation
struct block{
    var id: Int = 0
    var blockArr: [[[Int]]] = []
    
    func rotate(_ val: [[Int]]) -> [[Int]]{
        var newArr: [[Int]] = []
        for i in 1...val[0].count{
            var a: [Int] = []
            for j in 0..<val.count{
                a.append(val[j][val[0].count-i])
            }
            newArr.append(a)
        }
        return newArr
    }
    
    init(_ val: [[Int]], _ id: Int) {
        self.id = id
        self.blockArr.append(val)
        var rotateVal = val

        for _ in 0..<3{
            rotateVal = self.rotate(rotateVal)
            if !self.blockArr.contains(rotateVal){
                self.blockArr.append(rotateVal)
            }
        }
    }
}

var maxSize = 0
var visited: [[Bool]] = []
var puzzleSet: [Int : [block]] = [:]
var boardSet: [Int: [[[Int]]]] = [:]
let dx = [1,0,-1,0]
let dy = [0,-1,0,1]
var max = 0

func solution(_ game_board:[[Int]], _ table:[[Int]]) -> Int {
    maxSize = game_board.count
    visited = [[Bool]](repeating:[Bool](repeating: false,count: maxSize),count: maxSize)
    
    // puzzle
    var index = 1
    for i in 0..<maxSize{
        for j in 0..<maxSize{
            if table[i][j] == 1 && !visited[i][j]{
                cut(i,j,table,index,1)
                index += 1
                continue
            }
            visited[i][j] = true
        }
    }
    visited = [[Bool]](repeating:[Bool](repeating: false,count: maxSize),count: maxSize)
    for i in 0..<maxSize{
        for j in 0..<maxSize{
            if game_board[i][j] == 0 && !visited[i][j]{
                cut(i,j,game_board,index,0)
                continue
            }
            visited[i][j] = true
        }
    }
    for (key, value) in puzzleSet{
        guard let board = boardSet[key] else{
            continue
        }
        var newVal = value
        for b in board{
            for n in newVal{
                if n.blockArr.contains(b){
                    max += key
                    newVal = newVal.filter{$0.id != n.id}
                    break
                }
            }
        }
    }

    return max
}
func cut(_ x: Int, _ y: Int,_ table: [[Int]], _ index: Int,_ value: Int){
    var newArr:[[Int]] = []
    var nodeArr = [[x,y]]
    visited[x][y] = true
    while !nodeArr.isEmpty{
        let a = nodeArr.removeFirst()
        newArr.append(a)
        for k in 0..<4{
            if check(a[0]+dx[k],a[1]+dy[k]){
                if table[a[0]+dx[k]][a[1]+dy[k]] == value{
                    nodeArr.append([a[0]+dx[k],a[1]+dy[k]])
                    visited[a[0]+dx[k]][a[1]+dy[k]] = true
                }
            }
        }
    }
    makePiece(newArr,index,value)
    return
}

func makePiece(_ arr: [[Int]],_ index: Int, _ value: Int){
    let xarr = arr.map{$0[0]}
    let yarr = arr.map{$0[1]}
    let xMin: Int = xarr.min()!
    let xMax: Int = xarr.max()!
    let yMin: Int = yarr.min()!
    let yMax: Int = yarr.max()!
    
    var node = [[Int]](repeating: [Int](repeating: 0, count:yMax-yMin+1), count: xMax-xMin+1)
    var size = 0
    for i in xMin...xMax{
        for j in yMin...yMax{
            if arr.contains([i,j]){
                node[i-xMin][j-yMin] = 1
                size += 1
            }
        }
    }
    if value == 1{
        if puzzleSet[size] == nil{
            puzzleSet[size] = [block(node,index)]
        }else{
            puzzleSet[size]!.append(block(node,index))
        }
    }else{
        if boardSet[size] == nil{
            boardSet[size] = [node]
        }else{
            boardSet[size]!.append(node)
        }
    }
    return
}

func check(_ x: Int, _ y: Int) -> Bool{
    return isBound(x,y) && !visited[x][y]
}

func isBound(_ x: Int, _ y: Int) -> Bool{
    return x >= 0 && y >= 0 && x < maxSize && y < maxSize
}
