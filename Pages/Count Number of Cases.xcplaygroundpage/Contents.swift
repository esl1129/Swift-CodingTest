import Foundation

var answer = 0
var zeroCount: [Int] = []
var row = 0
var col = 0
func solution(_ a:[[Int]]) -> Int {
    row = a.count
    col = a[0].count
    for i in 0..<col{
        var count = 0
        for j in 0..<row{
            if a[j][i] == 0{
                count += 1
            }
        }
        zeroCount.append(count)
    }

    makeAnswer(0,0,1)
    return answer%190000000
}

func makeAnswer(_ depth: Int, _ check: Int, _ caseCount: Int){
    if depth == col{
        answer += check%2==0 ? caseCount%190000000 : 0
    }
    if zeroCount[depth] == 0 || row == zeroCount[depth]{
        makeAnswer(depth+1,check, caseCount)
    }else{
        var z = combination(zeroCount[depth])
        var o = combination(row-zeroCount[depth])
        
        makeAnswer(depth+1,check, caseCount*z)
        makeAnswer(depth+1,check+1, caseCount*o)
    }
}

func combination(_ r: Int) -> Int{
    let r = row-r > r ? r : row-r
    var result = 1
    for i in 0..<r{
        result *= (row-i)
    }
    for i in 1...r{
        result /= i
    }
    
    return result%190000000
}
