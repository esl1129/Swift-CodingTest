import Foundation

func solution(_ food_times:[Int], _ k:Int64) -> Int {
    if food_times.reduce(0, +) <= k {
        return -1
    }
    
    var k = Int(k)
    var food = [(key: Int, value: Int)]()

    for (index,data) in food_times.enumerated() {
        food.append((index+1, data))
    }
    food.sort{$0.value < $1.value}

    let size = food.count
    var before = 0
    var now = 0
    
    while size > now && k >= (food[now].value - before) * (size-now) {
        if food[now].value != before {
            k -= (food[now].value - before) * (size-now)
            before = food[now].value
        }
        now += 1
    }
    food = food[now..<size].sorted{$0.key < $1.key}
    return food[k % food.count].key
}
