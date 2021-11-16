import Foundation

func solution(_ gems:[String]) -> [Int] {
    var startNum = 0
    var endNum = gems.count
    var l = 0
    var r = -1
    var gemsCategoryCount = Set(gems).count
    var gemsDict:[String:Int] = [:]
    var count = 0
    
    while l < gems.count && r < gems.count {
        count = gemsDict.count

        if count == gemsCategoryCount {
            if (endNum - startNum) > (r - l) {
                startNum = l
                endNum = r
            }
            if l == r {
                break
            }
            
            if let value = gemsDict[gems[l]] {
                if value == 1 {
                    gemsDict[gems[l]] = nil
                }
                else {
                    gemsDict[gems[l]] = value - 1
                }
            }
            l += 1
        }
        else {
            r += 1
            if r < gems.count {
                if let value = gemsDict[gems[r]]{
                    gemsDict[gems[r]] = value + 1
                }
                else {
                    gemsDict[gems[r]] = 1
                }
            }
        }
    }
    return [startNum+1, endNum+1]
}
