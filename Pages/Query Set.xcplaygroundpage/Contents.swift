import Foundation

let MOD = 998244353
func solution(_ q:Int, _ a:[Int]) -> Int {
    // Make SubString Array
    func makesubStr(_ arr: [Int], _ idx: Int){
        if idx == aSize-1{
            return
        }
        for i in idx+1..<aSize{
            subStrArr.append(arr+[a[i]])
            makesubStr(arr+[a[i]], i)
        }
        return
    }
    var subStrArr = [[Int]]()
    let aSize = a.count
    makesubStr([],-1)
    
    // Make Factorial Dictionary
    var factorial = [Int:Int]()
    var num = 1
    for i in 1...q{
        num *= i
        num %= MOD
        factorial[i] = num
    }
    
    // Make DP Array
    var aux = [[Int]](repeating: [Int](repeating: 0, count: q+1), count: q+1)
    aux[0][0] = 1
    for i in 0..<q{
        for j in i..<q{
            for k in 1...q-j{
                aux[i+1][j+k] += aux[i][j]/factorial[k]!%MOD
            }
        }
    }
    
    print(subStrArr)
    print(aux)
    
    return -1
}

