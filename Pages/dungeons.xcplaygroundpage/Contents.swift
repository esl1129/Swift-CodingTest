import Foundation

var size = 0
var answer = 0
func solution(_ k:Int, _ dungeons:[[Int]]) -> Int {
    size = dungeons.count
    let visited = [Bool](repeating: false,count: size)
    DFS(dungeons,visited, 0, k)
    return answer
}

func DFS(_ dungeons: [[Int]], _ visited: [Bool], _ depth: Int, _ nowK: Int){
    if depth > answer{
        answer = depth
    }
    for i in 0..<size{
        if !visited[i] && dungeons[i][0] <= nowK{
            var newVisited = visited
            newVisited[i] = true
            DFS(dungeons,newVisited,depth+1,nowK-dungeons[i][1])
        }
        
    }
    return
}
