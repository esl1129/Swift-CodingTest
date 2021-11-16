import Foundation

var Dict = [Int:[Int]]()
var max = 0
var min = 101
func solution(_ n:Int, _ wires:[[Int]]) -> Int {
    max = n
    for wire in wires {
        if Dict[wire[0]] == nil{
            Dict[wire[0]] = [wire[1]]
        }else{
            Dict[wire[0]]!.append(wire[1])
        }
        if Dict[wire[1]] == nil{
            Dict[wire[1]] = [wire[0]]
        }else{
            Dict[wire[1]]!.append(wire[0])
        }
    }
    
    for wire in wires {
        let arr = Dict[wire[0]]!
        BFS(arr.filter{$0 != wire[1]},[wire[0]])
    }
    return min
}

func BFS(_ arr: [Int],_ visited: [Int]){
    if arr.isEmpty{
        let now = abs(max - (visited.count*2))
        if now < min{
            min = now
        }
        return
    }
    var newArr: [Int] = []
    var newVisited = visited
    for a in arr{
        if !newVisited.contains(a){
            newVisited.append(a)
            guard let dictArr = Dict[a] else{
                continue
            }
            for k in dictArr{
                if !newVisited.contains(k){
                    newArr.append(k)
                }
            }
        }
    }
    BFS(newArr,newVisited)
    return
}
