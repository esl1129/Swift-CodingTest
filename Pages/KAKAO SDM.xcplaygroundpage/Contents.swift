import Foundation

func solution(_ sales:[Int], _ links:[[Int]]) -> Int {
    func search(_ num: Int){
        Cost[num][0] = 0
        Cost[num][1] = sales[num-1]
        if linkDict[num] != nil{
            var min = Int.max
            var pass = false
            for val in linkDict[num]!{
                search(val)
                if Cost[val][0] < Cost[val][1]{
                    Cost[num][0] += Cost[val][0]
                    Cost[num][1] += Cost[val][0]
                    let now = Cost[val][1] - Cost[val][0]
                    if now < min { min = now }
                }
                else{
                    Cost[num][0] += Cost[val][1]
                    Cost[num][1] += Cost[val][1]
                    pass = true
                }
            }
            if !pass { Cost[num][0] += min}
        }
        return
    }
    
    var Cost = [[Int]](repeating:[Int.max,Int.max],count: sales.count+1)
    var linkDict: [Int: Set<Int>] = [:]
    for link in links{
        if linkDict[link[0]] == nil{
            linkDict[link[0]] = [link[1]]
        }else{
            linkDict[link[0]]!.insert(link[1])
        }
    }
    
    search(1)
    return Cost[1].min()!
}
