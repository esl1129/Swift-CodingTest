import Foundation

func solution(_ n:Int, _ start:Int, _ end:Int, _ roads:[[Int]], _ traps:[Int]) -> Int {
    var edgeArr = [[[Int]]](repeating: [[Int]](repeating: [], count: n+1), count: n+1)
    var globalStatus = [Int](repeating: 1, count: n+1)
    let visited = [[[Bool]]](repeating: [[Bool]](repeating: [false,false,false,false], count: n+1), count: n+1)
    var answer = 0
    var queue: [Int] = [start]
    for road in roads {
        edgeArr[road[0]][road[1]].append(road[2])
        edgeArr[road[1]][road[0]].append(-road[2])
    }
    
    while !queue.isEmpty{
        var nowStatus = globalStatus
        for _ in queue.indices{
            let a = queue.popLast()
            for (index,arr) in edgeArr[a!].enumerated(){
                if arr.isEmpty { continue }
                for a in arr{
                    
                }
            }
        }
    }
    return 0
}
