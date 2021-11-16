import Foundation

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var arr = [[Int]](repeating: [Int](repeating: 100000, count: n+1), count: n+1)
    for fare in fares{
        if arr[fare[0]][fare[1]] > fare[2]{
            arr[fare[0]][fare[1]] = fare[2]
        }
        if arr[fare[1]][fare[0]] > fare[2]{
            arr[fare[1]][fare[0]] = fare[2]
        }
    }
    for waypoint in 1...n{
        for start in 1...n{
            for end in 1...n{
                if arr[start][end] > arr[start][waypoint] + arr[waypoint][end]{
                    arr[start][end] = arr[start][waypoint] + arr[waypoint][end]
                }
            }
        }
    }
    
    var answer = arr[s][a] + arr[s][b] // 환승 X
    for i in 1...n{
        if i != s {
            if i == a{
                answer = arr[s][a]+arr[a][b] < answer ? arr[s][a]+arr[a][b] : answer
            }else if i == b{
                answer = arr[s][b]+arr[b][a] < answer ? arr[s][b]+arr[b][a] : answer
            }else{
                answer = arr[s][i]+arr[i][a]+arr[i][b] < answer ? arr[s][i]+arr[i][a]+arr[i][b] : answer
            }
        }
    }
    return answer
}
