import Foundation

func solution(_ values:[Int], _ edges:[[Int]], _ queries:[[Int]]) -> [Int64] {
    let size = values.count
    var value = values
    var childToParent: [Int:Int] = [:]
    var parentToChild: [Int:Int] = [:]
    var edgeArr = [[Int]](repeating: [], count: size+1)
    var visit = [Bool](repeating: false, count: size+1)
    for edge in edges {
        edgeArr[edge[0]].append(edge[1])
        edgeArr[edge[1]].append(edge[0])
    }
    
    var queue: [Int] = [1]
    visit[1] = true
    while !queue.isEmpty{
        let a = queue.removeFirst()
        for child in edgeArr[a]{
            if visit[child] { continue }
            childToParent[child] = a
            visit[child] = true
            queue.append(child)
        }
    }
    print(childToParent)
    return []
}
