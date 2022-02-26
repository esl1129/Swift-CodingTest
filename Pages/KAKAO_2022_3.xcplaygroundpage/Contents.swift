import Foundation

struct CAR {
    var IN: Int
    var OUT: Int
    var sum: Int
    init(){
        self.IN = 0
        self.OUT = 1439
        self.sum = 0
    }
    mutating func getSum(){
        self.sum += OUT-IN
        self.IN = 1439
        self.OUT = 1439
    }
    
}
func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    func getPrice(_ sum: Int) -> Int{
        if sum > fees[0] {
            let newSum = sum-fees[0]
            let cnt = newSum%fees[2] == 0 ? newSum/fees[2] : newSum/fees[2]+1
            return fees[1]+fees[3]*cnt
        }
        return fees[1]
    }
    
    var dict = [Int: CAR]()
    var answer = [Int]()
    
    for record in records {
        let line = record.components(separatedBy: " ").map{String($0)}
        let time = line[0].components(separatedBy: ":").map{Int(String($0))!}
        let timeNum = time[0]*60+time[1]
        let num = Int(line[1])!
        let command = line[2]
        if command == "IN" {
            if dict[num] == nil {
                dict[num] = CAR()
            }
            dict[num]!.IN = timeNum
        } else {
            dict[num]!.OUT = timeNum
            dict[num]!.getSum()
        }
    }
    
    for (key, value) in dict {
        dict[key]!.getSum()
    }
    
    for (key, value) in dict.sorted{$0.key < $1.key} {
        answer.append(getPrice(value.sum))
    }
    return answer
}

