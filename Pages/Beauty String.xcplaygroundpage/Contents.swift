func solution(_ s:String) -> Int64 {
    func appendToLumps(_ key: String, _ value: Int){
        if lumps[key] == nil{
            lumps[key] = [value:1]
        }else if lumps[key]![value] == nil{
            lumps[key]![value] = 1
        }else{
            lumps[key]![value]! += 1
        }
    }
    
    let strArr = s.map{String($0)}
    let size = strArr.count
    var lumps: [String:[Int:Int]] = [:]
    var sum: Int64 = (Int64(size-1)*Int64(size)*Int64(size+1))/6
    var now = 1
    for i in 1..<size{
        if strArr[i-1] == strArr[i]{
            now += 1
            continue
        }
        appendToLumps(strArr[i-1], now)
        now = 1
    }
    appendToLumps(strArr[size-1], now)
    
    
    for lumpVal in lumps.values{
        var total:Int64 = Int64(lumpVal.map{$0.key * $0.value}.reduce(0,+))
        var side:Int64 = Int64(lumpVal.map{$0.value}.reduce(0, +))
        for i in 1...lumpVal.keys.max()!{
            sum -= (total*(total-1))/2
            total -= side
            side -= Int64(lumpVal[i] ?? 0)
        }
    }
    return sum
}
