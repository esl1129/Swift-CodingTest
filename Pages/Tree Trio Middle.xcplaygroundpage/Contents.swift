import Foundation

var maxLen = 0
var edgeArr: [[Int]] = []
func solution(_ n:Int, _ edges:[[Int]]) -> Int {
    maxLen = n
    edgeArr = [[Int]](repeating: [],count: n+1)
    for edge in edges {
        edgeArr[edge[0]].append(edge[1])
        edgeArr[edge[1]].append(edge[0])
    }
    /// Step 1, 시작지점으로부터 가장 먼 노드 찾기
    var start = 1
    var result = BFS(start)
    for i in 2...n{
        if result[i] > result[start] { start = i }
    }
    
    /// Step 2, Step1에서 찾은 노드로 부터 가장 먼 노드들 찾기 만약 2개이상이면 return
    var cnt = 1
    result = BFS(start)
    for i in 1...n{
        if result[i] == result[start] { cnt += 1 }
        if result[i] > result[start] {
            start = i
            cnt = 1
        }
    }
    if cnt > 1 { return result[start] }
    
    /// Step 3, Step2에서 찾은 노드가 1개일때 해당 노드로 부터 가장 먼 노드들 찾기 만약 2개이상이면 result[start] 아니면 지름(result[start]-1) 리턴
    cnt = 1
    result = BFS(start)
    for i in 1...n{
        if result[i] == result[start] {
            cnt += 1
        }
        if result[i] > result[start] {
            start = i
            cnt = 1
        }
    }
    return cnt > 1 ? result[start] : result[start]-1
}

func BFS(_ start: Int) -> [Int]{
    var visited = [Bool](repeating: false,count: maxLen+1)
    var dist = [Int](repeating: 0,count: maxLen+1)
    var queueArr: [Int] = []
    queueArr.append(start)
    visited[start] = true
    
    while !queueArr.isEmpty {
        let now = queueArr.removeFirst()
        for i in edgeArr[now]{
            if visited[i] { continue }
            visited[i] = true
            queueArr.append(i)
            dist[i] = dist[now] + 1
        }
    }
    return dist
}
