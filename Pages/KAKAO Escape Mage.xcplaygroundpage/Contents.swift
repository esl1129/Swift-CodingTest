import Foundation



func solution(_ n:Int, _ start:Int, _ end:Int, _ roads:[[Int]], _ traps:[Int]) -> Int {
    func search(_ start: Int, _ visited: [[[Bool]]], _ depth: Int){
        if traps.contains(start){
            status[start] *= -1
        }
        let nowStatus = status
        for i in 1...n{
            var ca = status[start] == -1 ? 1 : 0
            ca += status[i] == -1 ? 2 : 0
            let num = edgeArr[start][i]*nowStatus[start]*nowStatus[i]
            if num > 0 && !visited[start][i][ca]{
                if num + depth < min[i] || min[i] == -1{
                    min[i] = num+depth
                }
                var newVisit = visited
                newVisit[start][i][ca] = true
                search(i,newVisit, depth+num)
            }
        }
        return
    }
    
    var edgeArr = [[Int]](repeating: [Int](repeating: 0, count: n+1), count: n+1)
    var status = [Int](repeating: 1, count: n+1)
    let visited = [[[Bool]]](repeating: [[Bool]](repeating: [false,false,false,false], count: n+1), count: n+1)
    var min = [Int](repeating: -1, count: n+1)

    min[start] = 0
    for road in roads {
        edgeArr[road[0]][road[1]] = road[2]
        edgeArr[road[1]][road[0]] = -road[2]
    }
    search(start,visited, 0)
    return min[end]
}
