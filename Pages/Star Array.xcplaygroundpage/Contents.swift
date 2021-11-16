import Foundation

func solution(_ a:[Int]) -> Int {
    var dict = [Int: Int]()
    var size = a.count
    for a in a{
        if dict[a] == nil{
            dict[a] = 1
        }else{
            dict[a]! += 1
        }
    }
    var cnt = 0
    for (key, value) in dict.sorted{$0.value > $1.value}{
        if value < cnt { break }
        var now = 0
        var idx = 1
        while idx < size{
            if (a[idx-1] != key && a[idx] != key) || a[idx-1] == a[idx]{
                idx += 1
                continue
            }
            now += 1
            idx += 2
        }
        cnt = now > cnt ? now : cnt
    }
    
    return cnt*2
}
