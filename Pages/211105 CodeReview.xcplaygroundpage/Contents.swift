func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    func DFS(_ depth: Int,_ check: Set<Int>){
        if depth == indexArr.count{
            answer.insert(check)
            return
        }
        for a in indexArr[depth]{
            if !check.contains(a){
                var newCheck = check
                newCheck.insert(a)
                DFS(depth+1,newCheck)
            }
        }
        return
    }
    
    
    var indexArr = [Set<Int>](repeating: [],count: banned_id.count)
    var answer = Set<Set<Int>>()
    for (i,ban) in banned_id.enumerated(){
        let size = ban.count // Time Complexity O(n)
        for (j,user) in user_id.enumerated(){
            if user.count != size { continue }
            var check = true
            for k in 0..<size{
                let offset = ban.index(ban.startIndex, offsetBy: k)
                if ban[offset] != "*" && ban[offset] != user[offset] {
                    check = false
                    break
                }
            }
            if check{
                indexArr[i].insert(j)
            }
        }
    }
    DFS(0,[])
    return answer.count
}

