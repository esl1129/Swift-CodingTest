import Foundation

var dx = [-1,0,1,0]
var dy = [0,1,0,-1]

var cycle: [[[Bool]]] = []
var gridString: [[String]] = []
var answer: [Int] = []
var rowMax: Int = 0
var colMax: Int = 0

func solution(_ grid:[String]) -> [Int] {
    //dir up,right,down,left
    rowMax = grid.count
    colMax = grid[0].count
    
    // grid split to String
    for g in grid{
        let arr = g.map { String($0) }
        gridString.append(arr)
    }
    
    for _ in 0..<rowMax{
        var boolArr: [[Bool]] = []
        for _ in 0..<colMax{
            boolArr.append([false, false, false, false])
        }
        cycle.append(boolArr)
    }
    
    for i in 0..<rowMax{
        for j in 0..<colMax{
            for d in 0..<4{
                if !cycle[i][j][d]{
                    checkCycle(i,j,d)
                }
            }
        }
    }
    return answer.sorted{$0 < $1}
}

func changeDir(_ x: Int, _ y: Int, _ dir: Int) -> Int{
    if gridString[x][y] == "R"{
        return dir+1 > 3 ? 0 : dir+1
    }else if gridString[x][y] == "L"{
        return dir-1 < 0 ? 3 : dir-1
    }
    return dir
}

func checkCycle(_ x: Int, _ y: Int, _ dir: Int){
    var xx = x
    var yy = y
    var dd = dir
    var count = 0
    while !cycle[xx][yy][dd]{
        cycle[xx][yy][dd] = true
        xx = xx+dx[dd] >= rowMax ? 0 : xx+dx[dd] < 0 ? rowMax-1 : xx+dx[dd]
        yy = yy+dy[dd] >= colMax ? 0 : yy+dy[dd] < 0 ? colMax-1 : yy+dy[dd]
        dd = changeDir(xx, yy, dd)
        count += 1
    }
    answer.append(count)
}
