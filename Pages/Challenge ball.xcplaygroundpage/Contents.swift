import Foundation

var maxRow = 0
var maxCol = 0
var box: [Int] = []
func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ queries:[[Int]]) -> Int64 {
    maxRow = n-1
    maxCol = m-1
    let size = queries.count-1
    
    box = [x,x,y,y] // top,bottom,left,right
    for i in queries.indices{
        let query = queries[size-i]
        if check(query[0]){
            plus(query)
        }else{
            move(query)
        }
    }
    let row = n == 1 ? 1 : box[1]-box[0]+1
    let col = m == 1 ? 1 : box[3]-box[2]+1
    return Int64(row*col)
}
func check(_ dir: Int) -> Bool{
    return (dir == 0 && box[2] == 0) || (dir == 1 && box[3] == maxCol) || (dir == 2 && box[0] == 0) || (dir == 3 && box[1] == maxRow)
 
}

func plus(_ query: [Int]){
    switch query[0]{
    case 0: // col+
        box[3] = box[3]+query[1] > maxCol ? maxCol : box[3]+query[1]
    case 1: // col-
        box[2] = box[2]-query[1] < 0 ? 0 : box[2]-query[1]
    case 2: // row+
        box[1] = box[1]+query[1] > maxRow ? maxRow : box[1]+query[1]
    case 3: // row-
        box[0] = box[0]-query[1] < 0 ? 0 : box[0]-query[1]
    default:
        break
    }
    return
}
func move(_ query: [Int]){
    switch query[0]{
    case 0: // col+
        box[2] = box[2]+query[1] > maxCol ? maxCol : box[2]+query[1]
        box[3] = box[3]+query[1] > maxCol ? maxCol : box[3]+query[1]
    case 1: // col-
        box[2] = box[2]-query[1] < 0 ? 0 : box[2]-query[1]
        box[3] = box[3]-query[1] < 0 ? 0 : box[3]-query[1]
    case 2: // row+
        box[0] = box[0]+query[1] > maxRow ? maxRow : box[0]+query[1]
        box[1] = box[1]+query[1] > maxRow ? maxRow : box[1]+query[1]
    case 3: // row-
        box[0] = box[0]-query[1] < 0 ? 0 : box[0]-query[1]
        box[1] = box[1]-query[1] < 0 ? 0 : box[1]-query[1]
    default:
        break
    }
    return
}
