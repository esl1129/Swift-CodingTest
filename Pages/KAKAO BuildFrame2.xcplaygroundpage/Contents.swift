import Foundation

var state: [[Int]] = []
var N: Int = 0

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    N = n
    state = []
    
    build_frame.forEach { data in
        // Build
        if data[3] == 1 && data[0] <= (data[2] == 0 ? N : N-1) && data[1] <= (data[2] == 0 ? N-1 : N)
            && ((data[2] == 0) ? checkPillarBuildable(data, state) : checkBeamBuildable(data, state)) {
            state.append([data[0], data[1], data[2]])
        }
        // Remove
        if data[3] == 0 && state.contains([data[0],data[1],data[2]]) && checkRemovable(data) {
            state = state.filter { $0 != [data[0],data[1],data[2]] }
        }
    }
    
    return state
        .sorted { a, b -> Bool in
            for i in 0..<a.count {
                if a[i] == b[i] { continue }
                return a[i] < b[i]
            }
            return false
        }
}

func checkPillarBuildable(_ data: [Int], _ state: [[Int]]) -> Bool {
    if data[1] == 0 { return true }
    let isOnAnotherPillar = state.contains([data[0],data[1]-1,0])
    let isOnSideOfBeam = state.contains([data[0]-1,data[1],1]) || state.contains([data[0],data[1],1])
    return isOnAnotherPillar || isOnSideOfBeam
}

func checkBeamBuildable(_ data: [Int], _ state: [[Int]]) -> Bool {
    guard data[1] > 0 else { return false }
    let isOnPillar = state.contains([data[0], data[1]-1, 0]) || state.contains([data[0]+1, data[1]-1, 0])
    let isBetweenBeams = state.contains([data[0]-1, data[1], 1]) && state.contains([data[0]+1, data[1], 1])
    return isOnPillar || isBetweenBeams
}

func checkRemovable(_ data: [Int]) -> Bool {
    let newState = state.filter { $0 != data.dropLast() }
    
    return newState
        .filter {
            if (data[2] == 0) {
                return ($0 == [data[0], data[1]+1, 0]
                        || $0 == [data[0], data[1]+1, 1]
                        || $0 == [data[0]-1, data[1]+1, 1])
            }
            return ($0 == [data[0]-1, data[1], 1]
                    || $0 == [data[0]+1, data[1], 1]
                    || $0 == [data[0]+1, data[1], 0]
                    || $0 == [data[0], data[1], 0])
        }
        .map { ($0[2] == 0) ? checkPillarBuildable($0, newState) : checkBeamBuildable($0, newState) }
        .reduce(true) { $0 && $1 }
}
