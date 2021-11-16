import Foundation

var isVisited: [[Int]] = []
var arr: [[Int]] = []
var answer = 0
func solution(_ board:[[Int]]) -> Int {
    arr.append([0,0,1])
    isVisited.append([0,0,1])
    
    func check(_ x: Int, _ y: Int, _ dir: Int) -> Bool{
        if !isVisited.contains([x,y,dir]){
            if isWall(x, y, dir){
                return true
            }
        }
        return false
    }
    
    func inRange(_ x: Int, _ y: Int) -> Bool{
        if x < 0 || x > board.count-1 || y < 0 || y > board.count-1{
            return false
        }
        return true
    }
    
    func isWall(_ x: Int, _ y: Int, _ dir: Int) -> Bool{
        if dir < 3{
            if inRange(x, y) && inRange(x, y+1){
                if board[x][y] == 0 && board[x][y+1] == 0{
                    return true
                }
            }
        }else{
            if inRange(x, y) && inRange(x+1, y){
                if board[x][y] == 0 && board[x+1][y] == 0{
                    return true
                }
            }
        }
        return false
    }
    
    while arr.count > 0{
        for _ in 0..<arr.count{
            let a = arr.removeFirst()
            if a == [board.count-1, board.count-2 ,1] || a == [board.count-2, board.count-1 ,3]{
                return answer
            }
            if check(a[0], a[1]-1, a[2]){
                arr.append([a[0], a[1]-1, a[2]])
                isVisited.append([a[0], a[1]-1, a[2]])
            }
            if check(a[0], a[1]+1, a[2]){
                arr.append([a[0], a[1]+1, a[2]])
                isVisited.append([a[0], a[1]+1, a[2]])
            }
            if check(a[0]-1, a[1], a[2]){
                arr.append([a[0]-1, a[1], a[2]])
                isVisited.append([a[0]-1, a[1], a[2]])
            }
            if check(a[0]+1, a[1], a[2]){
                arr.append([a[0]+1, a[1], a[2]])
                isVisited.append([a[0]+1, a[1], a[2]])
            }
            if a[2] < 2{ // left & right
                if isWall(a[0]-1, a[1], a[2]){
                    if check(a[0]-1, a[1], 3){
                        arr.append([a[0]-1, a[1], 3])
                        isVisited.append([a[0]-1, a[1], 3])
                    }
                    if check(a[0]-1, a[1]+1, 3){
                        arr.append([a[0]-1, a[1]+1, 3])
                        isVisited.append([a[0]-1, a[1]+1, 3])
                    }
                }
                if isWall(a[0]+1, a[1], a[2]){
                    if check(a[0], a[1], 3){
                        arr.append([a[0], a[1], 3])
                        isVisited.append([a[0], a[1], 3])
                    }
                    if check(a[0], a[1]+1, 3){
                        arr.append([a[0], a[1]+1, 3])
                        isVisited.append([a[0], a[1]+1, 3])
                    }
                }
            }else{ //up & down
                if isWall(a[0], a[1]-1, a[2]){
                    if check(a[0], a[1]-1, 1){
                        arr.append([a[0], a[1]-1, 1])
                        isVisited.append([a[0], a[1]-1, 1])
                    }
                    if check(a[0]+1, a[1]-1, 1){
                        arr.append([a[0]+1, a[1]-1, 1])
                        isVisited.append([a[0]+1, a[1]-1, 1])
                    }
                }
                if isWall(a[0], a[1]+1, a[2]){
                    if check(a[0], a[1], 1){
                        arr.append([a[0], a[1], 1])
                        isVisited.append([a[0], a[1], 1])
                    }
                    if check(a[0]+1, a[1], 1){
                        arr.append([a[0]+1, a[1], 1])
                        isVisited.append([a[0]+1, a[1], 1])
                    }
                }
            }
        }
        answer += 1
    }
    
    return answer
}
