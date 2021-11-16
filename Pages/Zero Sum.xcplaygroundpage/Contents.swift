import Foundation

var answer: Int64 = 0
var children = [[Int]]()
var weights = [Int]()

func solution(_ a:[Int], _ edges:[[Int]]) -> Int64 {
    children = Array(repeating: [Int](), count: a.count)
    weights = a
    if weights.reduce(0,+) == 0 {
        for edge in edges {
            children[edge[0]].append(edge[1])
            children[edge[1]].append(edge[0])
        }
        findLeafNode(current: 0, parent: 0)
        return answer
    }
    return -1
}

func findLeafNode(current:Int,parent:Int) {
    for child in children[current] {
        if child != parent  {
            findLeafNode(current: child, parent: current)
        }
    }
    weights[parent] += weights[current]
    answer += Int64(abs(weights[current]))
}
