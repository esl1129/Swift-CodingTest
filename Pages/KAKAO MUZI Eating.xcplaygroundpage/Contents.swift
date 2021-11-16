import Foundation

func solution(_ food_times:[Int], _ k:Int64) -> Int {
    guard food_times.reduce(0, +) > k else {
        return -1
    }
    
    var k = Int(k)
    var food = [(key: Int, value: Int)]()

    for (index,data) in food_times.enumerated() {
        food.append((index+1, data))
    }
    food.sort{$0.value < $1.value}

    var before = 0
    var now = 0
    
    while !food[now..<food.endIndex].isEmpty &&
            k >= (food[now].value - before) * food[now..<food.endIndex].count {
        if food[now].value != before {
            k -= (food[now].value - before) * food[now..<food.endIndex].count
            before = food[now].value
        }
        now += 1
    }
    food = food[now..<food.endIndex].sorted{$0.key < $1.key}
    return food[k % food.count].key
}
