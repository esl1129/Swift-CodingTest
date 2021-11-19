import Foundation

let MOD = 998244353
func solution(_ q:Int, _ a:[Int]) -> Int {
    var aux = [[Int]](repeating: [Int](repeating: 0),count: q, count: q)
    var factorial = [Int:Int]()
    var num = 1
    for i in 1...q{
        num *= i
        factorial[i] = num
    }
    aux[0][0] = 1
    for i in 0..<q{
        for j in i..<q{
            for k in 1..<j{
                aux[i+1][j+k] = aux[i][j] / modInverse(factorial[k]!)
            }
        }
    }
    return -1
}

func modInverse(_ a: Int) -> Int{
    let tmp = a % MOD
    for i in 1..<MOD {
      if (tmp * i % m == 1) {
        return i
      }
    }
  return 0
}
