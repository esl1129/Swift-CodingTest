import Foundation

func solution(_ n:Int, _ k:Int) -> Int {
    func checkPrime(_ a: Int) -> Bool{
        for i in 2...Int(sqrt(Double(a))){
            if a%i == 0 { return false}
        }
        return true
    }
    
    let binary: String = k != 10 ? String(n, radix: k) : String(n)
    let arr = binary.components(separatedBy: "0").filter{$0 != ""}.map{Int(String($0))!}

    var answer = 0
    for a in arr {
        if a == 2 || a == 3 {
            answer += 1
            continue
        }
        if a < 4 || !checkPrime(a) { continue }
        answer += 1
    }
    return answer
}
