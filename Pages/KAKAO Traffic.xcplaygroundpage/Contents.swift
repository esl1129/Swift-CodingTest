func solution(_ lines:[String]) -> Int {
    var timeArr: [[Int]] = []
    var max = 0
    for line in lines{
        var split = line.components(separatedBy: " ")
        var time = split[1].components(separatedBy: ":")
        var ms = time[2].components(separatedBy: ".")
        var delay = String(split[2]).dropLast().components(separatedBy: ".")
        
        let EndTime = Int(time[0])!*60*60*1000 + Int(time[1])!*60*1000 + Int(ms[0])!*1000 + Int(ms[1])!
        var StartTime = EndTime-Int(delay[0])!*1000+1
        if delay.count > 1{
            StartTime -= Int(delay[1])!
        }
        timeArr.append([StartTime, EndTime+1000])
    }
    
    for (index,t) in timeArr.enumerated(){
        var now = 1
        for i in index+1..<timeArr.count{
            if timeArr[i][0] < t[1]{
                now += 1
            }
        }
        max = now > max ? now : max
    }
    return max
}
