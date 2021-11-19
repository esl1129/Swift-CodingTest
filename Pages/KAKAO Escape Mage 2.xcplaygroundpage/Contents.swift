import Foundation

struct Node{
    let index: Int
    let status: Int
    let trapDict: [Int:Int]
    let cost: Int
    
    init(_ index: Int, _ status: Int,_ cost: Int, _ trapDict: [Int:Int]){
        self.index = index
        self.status = status
        self.cost = cost
        self.trapDict = trapDict
    }
}
func solution(_ n:Int, _ start:Int, _ end:Int, _ roads:[[Int]], _ traps:[Int]) -> Int {
    var edgeArr = [[[Int]]](repeating: [[Int]](repeating: [-1,1], count: n+1), count: n+1)
    let visited = [[[[Bool]]]](repeating: [[[Bool]]](repeating: [[false,false],[false,false]], count: n+1), count: n+1)
    var graphDict: [Int:[Int]] = [:]
    var trapDict : [Int:Int] = [:]
    for trap in traps {
        trapDict[trap] = 0
    }
    var answer = Int.max
    var plus = 0
    var minus = 0
    for road in roads {
        plus = edgeArr[road[0]][road[1]][0]
        minus = edgeArr[road[0]][road[1]][1]
        edgeArr[road[0]][road[1]][0] = plus < 0 ? road[2] : plus < road[2] ? plus : road[2]
        edgeArr[road[0]][road[1]][1] = minus > 0 ? -road[2] : minus > -road[2] ? minus : -road[2]
    }
    
    var queue: [Node] = [Node(start, 1,0, trapDict)]
    while !queue.isEmpty{
        let a = queue.removeFirst()
        if a.cost > answer { continue }
        if graphDict[a.index] == nil { continue }
        for point in graphDict[a.index]!{
            if edgeArr[a.index][point][a.status]
            var start = a.status
            var end = a.trapDict[point] == nil ? 0 : a.trapDict[point]!
            if visited[a.index][point][start][end] { continue }
            if a.trapDict[point] == nil{
                
            }else{
                status += a.trapDict[point]!
                var newTrapDict = a.trapDict
                newTrapDict[point] = newTrapDict[point] == 0 ? 1 : 0
            }
        }
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
