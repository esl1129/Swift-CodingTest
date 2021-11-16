import Foundation

var moneyPerPeople:[String:Int] = [:]
var personDict:[String: String] = [:]

func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    moneyPerPeople["center"] = 0
    for i in enroll.indices{
        if referral[i] != "-"{
            personDict[enroll[i]] = referral[i]
        }else{
            personDict[enroll[i]] = "center"
        }
        moneyPerPeople[enroll[i]] = 0
    }
    for m in 0..<seller.count{
        moneySale(name: seller[m], money: amount[m]*100)
    }
    var answer: [Int] = []
    for e in enroll{
        answer.append(moneyPerPeople[e]!)
    }
    return answer
}

func moneySale(name: String, money: Int){
    if money < 10{
        moneyPerPeople[name]! += money
        return
    }
    if personDict[name] == nil{
        moneyPerPeople[name]! += money
        return
    }else{
        moneyPerPeople[name]! += (money-money/10)
        moneySale(name: personDict[name]!, money: money/10)
    }
}
