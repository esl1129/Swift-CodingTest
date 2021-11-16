import Foundation

let dx = [-1,0,1,0]
let dy = [0,-1,0,1]
var size = 0
var part = [[Int]]()
func solution(_ land:[[Int]], _ height:Int) -> Int {
    size = land.count
    part = [[Int]](repeating:[Int](repeating:0, count: size), count: size)

    var nodeArr = [[Int]]()
    var max = 1
    for i in 0..<size{
        for j in 0..<size{
            if part[i][j] != 0 { continue }
            nodeArr.append([i,j])
            part[i][j] = max
            while !nodeArr.isEmpty{
                let node = nodeArr.removeFirst()
                let x = node[0]
                let y = node[1]
                for i in 0..<4{
                    let xx = x + dx[i]
                    let yy = y + dy[i]
                    if check(xx,yy){
                        if abs(land[xx][yy] - land[x][y]) <= height{
                            part[xx][yy] = max
                            nodeArr.append([xx,yy])
                        }
                    }
                }
            }
            max += 1
        }
    }
    return dp(land,max)
}

func check(_ x: Int, _ y: Int) -> Bool{
    return !isBound(x,y) && part[x][y] == 0
}

func isBound(_ x: Int, _ y: Int) -> Bool{
    return x < 0 || y < 0 || x > size-1 || y > size-1
}

func dp(_ land: [[Int]], _ len: Int) -> Int{
    var isVisited = [[Bool]](repeating: [Bool](repeating: false, count: size), count: size)
    var minDp = [Int](repeating: Int.max, count: len)
    var nodeArr = [[Int]]()
    for i in 0..<size{
        for j in 0..<size{
            if isVisited[i][j] { continue }
            nodeArr.append([i,j])
            isVisited[i][j] = true
            while !nodeArr.isEmpty{
                let node = nodeArr.removeFirst()
                let x = node[0]
                let y = node[1]
                for i in 0..<4{
                    let xx = x + dx[i]
                    let yy = y + dy[i]
                    if !isBound(xx,yy) && !isVisited[xx][yy]{
                        let now = part[xx][yy] - part[x][y]
                        if now == 0{
                            nodeArr.append([xx,yy])
                            isVisited[xx][yy] = true
                            continue
                        }
                        let price = abs(land[xx][yy] - land[x][y])
                        minDp[part[xx][yy]] = price < minDp[part[xx][yy]] ? price : minDp[part[xx][yy]]
                    }
                }
            }
        }
    }
    return minDp.filter{$0 != Int.max}.reduce(0, +)
}
