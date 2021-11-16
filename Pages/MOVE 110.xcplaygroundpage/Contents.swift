import Foundation

func solution(_ s:[String]) -> [String] {
    var answer: [String] = []
    for str in s{
        let arr = str.map {String($0)}
        var count = 0
        var stack = [String]()
        
        for a in arr{
            if stack.count >= 2{
                let second = stack.removeLast()
                let first = stack.removeLast()
                if first == "1" && second == "1" && a == "0"{
                    count += 1
                }else{
                    stack.append(contentsOf:[first, second, a])
                }
            }else{
                stack.append(a)
            }
        }
        if count == 0{
            answer.append(stack.joined(separator:""))
            continue
        }
        var appendStr = ""
        for _ in 0..<count{
            appendStr += "110"
        }
        if stack.isEmpty || !stack.contains("0"){
            answer.append(appendStr + stack.joined(separator:""))
            continue
        }
        
        var answerElement = ""
        var a = stack.removeLast()
        while a != "0"{
            a = stack.removeLast()
            answerElement += "1"
        }
        stack.append(a)
        answerElement = stack.joined(separator:"") + appendStr + answerElement
        answer.append(answerElement)
    }
    return answer
}
