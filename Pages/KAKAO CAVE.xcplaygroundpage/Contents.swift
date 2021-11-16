import Foundation

func solution(_ n:Int, _ path:[[Int]], _ order:[[Int]]) -> Bool {
    func dfs(_ node: Int) {
        if visited[node] {
            return
        }
        if !visited[orderCheck[node]] {
            shouldVisit[orderCheck[node]] = node
            return
        }
        visited[node] = true
        dfs(shouldVisit[node])
        for num in graph[node] {
            dfs(num)
        }
    }
    
    var visited = [Bool](repeating: false, count: n)
    var graph = [[Int]](repeating: [], count: n)
    var orderCheck = [Int](repeating: 0, count: n)
    var shouldVisit = [Int](repeating: 0, count: n)

    for line in path {
        graph[line[0]].append(line[1])
        graph[line[1]].append(line[0])
    }
    
    for ord in order {
        orderCheck[ord[1]] = ord[0]
    }

    if orderCheck[0] != 0 {
        return false
    }

    visited[0] = true
    for i in 0..<graph[0].count {
        dfs(graph[0][i])
    }

    if visited.contains(false) {
        return false
    } else {
        return true
    }
}
