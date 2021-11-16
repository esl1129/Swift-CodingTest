import Foundation

typealias Info = (Int,Int,Int)
var heap = [(-1,-1,-1),(0,0,0)]
let dx = [-1,0,1,0]
let dy = [0,-1,0,1]
var size = 0

func solution(_ land: [[Int]], _ height: Int) -> Int {
    size = land.count
    var visited = Array(repeating: Array(repeating: false, count: size), count:size)
    
    func dfs(_ x: Int, _ y: Int){
        visited[x][y] = true
        for d in 0...3{
            let nx = x + dx[d]
            let ny = y + dy[d]
            if isBound(nx, ny) && !visited[nx][ny]{
                let diff = abs(land[x][y] - land[nx][ny])
                if diff > height{
                    push_heap((diff,nx,ny))
                }else{
                    dfs(nx, ny)
                }
            }
        }
    }
    
    var ans = 0
    while heap.count > 1{
        let info = pop_heap()
        if visited[info.1][info.2] { continue }
        ans += info.0
        dfs(info.1, info.2)
    }
    return ans
}

func isBound(_ x:Int , _ y: Int) -> Bool{
    return x >= 0 && y >= 0 && x < size && y < size
}

func push_heap(_ info:Info){
    var i=heap.count
    heap.append(info)
    while i > 1{
        let j = i >> 1
        if heap[j].0 > heap[i].0{
            heap.swapAt(j, i)
        }else{
            break
        }
        i = j
    }
}

func pop_heap() -> Info{
    heap.swapAt(1, heap.count-1)
    let ret = heap.removeLast()
    var i = 1
    while true{
        let j = i << 1
        var idx = 0
        if j < heap.count && heap[i].0>heap[j].0{
            idx = j
        }
        if j+1<heap.count && heap[i].0>heap[j+1].0 && heap[j].0>heap[j+1].0{
            idx = j+1
        }
        if idx<1{
            break
        }
        heap.swapAt(i, idx)
        i = idx
    }
    return ret
}
