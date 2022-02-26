import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    var fromCnt = [Int](repeating: 0, count: id_list.count)
    var idDict = [String: Int]()
    
    for (index, id) in id_list.enumerated() {
        idDict[id] = index
    }
    
    var reportDict = [String: Set<Int>]()
    
    for rep in report{
        let users = rep.components(separatedBy: " ").map{String($0)}
        let from = users[0]
        let to = users[1]
        
        if reportDict[to] == nil {
            reportDict[to] = [idDict[from]!]
        } else {
            reportDict[to]!.insert(idDict[from]!)
        }
    }
    for (key, value) in reportDict {
        if value.count >= k {
            for v in value {
                fromCnt[v] += 1
            }
        }
    }
    return fromCnt
}
