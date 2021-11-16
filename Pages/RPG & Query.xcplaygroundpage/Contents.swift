import Foundation

var roadPrice = [[Int]]()
var roadArr = [[Int]]()
var priceDict = [Int:Int]()
func solution(_ n:Int, _ z:Int, _ roads:[[Int]], _ queries:[Int64]) -> [Int64] {
    roadPrice = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    roadArr = [[Int]](repeating: [], count: n)
    for road in roads {
        roadPrice[road[0]][road[1]] = road[2]
        roadArr[road[0]].append(road[1])
    }
    priceDict[0] = 0
    priceDict[z] = 1
    
    let arr = roadArr[0].filter{$0 != 0}
    for a in arr{
        priceDict[a] = 1
    }
    for i in 0..<n{
        var newVisit = visited
        var queue: [Int] = [i]
        newVisit[i] = true
        while !queue.isEmpty{
            for (j,value) in roadArr[i].enumerated(){
                if value == 0 || visited[j] { continue }
                queue.append(j)
            }
        }
    }
    return []
}

func DFS(_ visited: [Bool],
