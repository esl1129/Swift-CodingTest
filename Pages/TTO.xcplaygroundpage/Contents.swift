import Foundation


func solution(_ n : Int , _ edges : [[Int]]) -> Int {
    var nodes = Array(repeating: [Int](), count : n+1)
    edges.forEach{
        nodes[$0[0]].append($0[1])
        nodes[$0[1]].append($0[0])
    }

    let values = Array(repeating : 0, count : n+1)
    var valueList = [values,values,values,values]

    func bfs(_ start : Int, _ index : Int, _ except : Int) -> Int {
        var visited = Array(repeating : false ,count : n+1)
        visited[start] = true

        var queue = [(start,0)]
        var cnt = 0
        var maxNode = 0
        var maxLength = 0
        while queue.count > cnt{
            let now = queue[cnt]
            cnt += 1
            for next in nodes[now.0] {
                if !visited[next] {
                    queue.append((next,now.1+1))
                    visited[next] = true
                    valueList[index][next] = max(valueList[index][next],now.1+1)
                    if now.1 + 1 > maxLength  && next != except {
                        maxNode = next
                        maxLength = now.1 + 1
                    }
                }
            }
        }
        return maxNode
    }


    let maxNode = bfs(1,0,0)
    let maxNode1 = bfs(maxNode,1,0)
    let maxNode2 = bfs(maxNode1,2,maxNode)
    let _ = bfs(maxNode2,3,0)
    let answers = [valueList[1][maxNode1], valueList[2][maxNode2], valueList[3][maxNode]]
    let answer = answers.sorted()[1]
    return answer

}
