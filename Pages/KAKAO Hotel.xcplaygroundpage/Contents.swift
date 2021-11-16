import Foundation

func solution(_ k:Int64, _ room_number:[Int64]) -> [Int64] {
    var answer: [Int64: Int64] = [:]
    var result = [Int64]()
    
    func find(_ num: Int64) -> Int64{
        return answer[num] == nil ? num : find(answer[num]!)
    }
    for room in room_number{
        if answer[room] == nil{
            result.append(room)
        }else{
            result.append(find(room))
        }
    }
    return result
}
