import Foundation

func solution(_ play_time:String, _ adv_time:String, _ logs:[String]) -> String {

    if play_time == adv_time {
        return "00:00:00"
    }

    let playTimeSeconds = makeSeconds(time: play_time)

    var allPlaySeconds:[Double] = Array(repeating: 0, count: playTimeSeconds+1)

    let advTimeSeconds = makeSeconds(time: adv_time)

    for log in logs {
        let startEnd = splitPlaytime(playtime: log)
        let start = makeSeconds(time: startEnd.0)
        let end = makeSeconds(time: startEnd.1)
        allPlaySeconds[start] += 1
        allPlaySeconds[end] -= 1
    }

    for i in 1...playTimeSeconds {
        allPlaySeconds[i] += allPlaySeconds[i-1]
    }
    
    var sum = allPlaySeconds[0..<advTimeSeconds].reduce(0,+)

    var maxSum:Double = sum
  
    var maxStart:Int = 0

    for i in advTimeSeconds..<playTimeSeconds {

        sum += allPlaySeconds[i] - allPlaySeconds[i - advTimeSeconds]
        
        if maxSum < sum {
            maxSum = sum
            maxStart = i - advTimeSeconds + 1
        }
    }
    return makeSecondsToString(seconds: maxStart)
}

func makeSecondsToString(seconds:Int) -> String {
    let hourString = 0...9 ~= seconds/3600 ? "0\(seconds/3600)" : "\(seconds/3600)"
    let minuteString = 0...9 ~= seconds/60%60 ? "0\(seconds/60%60)" : "\(seconds/60%60)"
    let secondString = 0...9 ~= seconds%60 ? "0\(seconds%60)" : "\(seconds%60)"

    return "\(hourString):\(minuteString):\(secondString)"
}

func makeSeconds(time:String) -> Int {
    let split = time.components(separatedBy: ":")
    let hour = Int(split[0])! * 60 * 60
    let minute = Int(split[1])! * 60
    let second = Int(split[2])!

    return hour + minute + second
}

func splitPlaytime(playtime:String) -> (String,String) {
    let playtimeSplit = playtime.components(separatedBy: "-")
    let start = playtimeSplit[0]
    let end = playtimeSplit[1]

    return (start,end)
}
