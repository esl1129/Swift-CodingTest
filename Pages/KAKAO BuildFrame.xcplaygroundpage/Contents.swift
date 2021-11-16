import Foundation

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    // frame [2]: 0-> pillar, 1-> floor , [3]: 0-> remove, 1-> append
    var pillar: [[Bool]] = Array(repeating: Array(repeating: false, count: n+1), count: n+1)
    var floor: [[Bool]] = Array(repeating: Array(repeating: false, count: n+1), count: n+1)

    for frame in build_frame{
        if frame[3] == 0{ // remove
            remove(frame[0], frame[1], frame[2])
        }else{ // append
            append(frame[0], frame[1], frame[2])
        }
    }
    
    func append(_ x: Int, _ y:Int, _ kind: Int){ // [3] -> 1
        if kind == 0{ // pillar
            if y == 0{ // 바닥일경우
                pillar[x][y] = true
            }else{
                if pillar[x][y-1] || floor[x][y]{
                    pillar[x][y] = true
                }else if x > 0 && floor[x-1][y]{
                    pillar[x][y] = true
                }
            }
        }else{ //floor
            if pillar[x][y-1] || pillar[x+1][y-1]{
                floor[x][y] = true
            }else if x > 0 && x < n-1{
                if floor[x+1][y] && floor[x-1][y]{
                    floor[x][y] = true
                }
            }
        }
    }
    
    func remove(_ x: Int, _ y:Int, _ kind: Int){ // [3] -> 0
        if kind == 0{ // pillar
            // 1.pillar[x][y+1]
            // 2.floor[x][y+1]
            // 3.floor[x-1][y+1] x > 0
            // 4. 1+2
            // 5. 1+3
            // 6. 2+3
            // 7. 1+2+3
            if pillar[x][y+1]{
                if floor[x][y+1] && x > 0 && floor[x-1][y+1]{
                    if x-1 > 0{
                        
                    }
                }else if floor[x][y+1] && x+1 < pillar.count && pillar[x+1][y]{
                    pillar[x][y] = false
                }else if x > 0 && floor[x-1][y+1] && pillar[x-1][y]{
                    pillar[x][y] = false
                }
            }else if floor[x][y+1]{
                
            }else if x > 0 && floor[x-1][y+1]{
                
            }else{
                pillar[x][y] = false
            }
        }else{ //floor
            
        }
    }
    print(pillar)
    print(floor)
    return []
}
