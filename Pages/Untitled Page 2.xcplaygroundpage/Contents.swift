import Foundation

func solution(_ lines:[String]) -> Int {
    var timeArr: [[Int]] = []
    var max = 0
    for line in lines{
        let split = line.components(separatedBy: " ")
        let time = split[1].components(separatedBy: ":") // HH:MM:SS.MS -> HH, MM, SS.MS
        let ms = time[2].components(separatedBy: ".") // SS.MS -> SS, MS
        let delay = String(split[2]).dropLast().components(separatedBy: ".") // S.MS"S" -> S.MS -> S, MS
        
        // 0~86,400,000 (ms)
        let EndTime = Int(time[0])!*60*60*1000 + Int(time[1])!*60*1000 + Int(ms[0])!*1000 + Int(ms[1])!
        let delaytime = delay.count > 1 ? Int(delay[0])!*1000+Int(delay[1])! : Int(delay[0])!*1000
        let StartTime = EndTime-delaytime+1
        
        timeArr.append([StartTime, EndTime+1000])
    }
    
    for (index,t) in timeArr.enumerated(){
        var now = 1
        for i in index+1..<timeArr.count{
            if timeArr[i][0] < t[1]{
                now += 1
            }
        }
        if now > max{ max = now }
    }
    return max
}
