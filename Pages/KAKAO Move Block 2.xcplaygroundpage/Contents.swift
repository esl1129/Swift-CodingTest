struct Current {
    var x:Int,y:Int,d:Direction,count:Int,past:Command
}

enum Command:CaseIterable {
    case up,down,left,right,rotateClockwise,rotateAntiClockwise,rotateClockwise2,rotateAntiClockwise2
}

enum Direction:CaseIterable {
    case right,down,left,up
}

//이미 방문한 곳을 방향별로 저장
var dontMove:[Direction:[[Bool]]] = [:]
//시계 방향 회전시 맨하튼거리
let clockManhattan:[Direction:(Int,Int)] = [.up:(-1,-1),.down:(+1,+1),.left:(-1,+1),.right:(+1,-1)]
//반시계 방향 회전시 맨하튼거리
let antiClockManhattan:[Direction:(Int,Int)] = [.up:(+1,-1),.down:(-1,+1),.left:(-1,-1),.right:(+1,+1)]
//방향에 따른 두번째 로봇 위치
let directionXY:[Direction:(Int,Int)] = [.up:(0,-1),.down:(0,+1),.left:(-1,0),.right:(+1,0)]

func solution(_ board:[[Int]]) -> Int {
    Direction.allCases.forEach{
        dontMove[$0] = Array(repeating: Array(repeating: false, count: board.count), count: board.count)
    }
    return findMinCountByBFS(board: board)
}

func findMinCountByBFS(board:[[Int]]) -> Int {
    let allCommand = Command.allCases
    var queue:[Current] = [Current(x: 0, y: 0, d: .right, count: 0, past: .right)]
    
    while !queue.isEmpty {
        var first = queue.removeFirst()
        let second = current2(current: first)
        
        if isEnabled(current: first, b: board) {
            if (first.x == board.count-1 && first.y == board.count-1) || (second.x == board.count-1 && second.y == board.count-1){
                return first.count
            }
            
            //방문 표시
            dontMove[first.d]![first.y][first.x] = true
            //카운트 1증가
            first.count += 1
            
            //명령별로 움직여줌
            for command in allCommand {
                var newCurrent = move(current: first, command: command)
                newCurrent.past = command
                queue.append(newCurrent)
            }
        }
    }
    return 0
}

//명령에 따라 움직인 위치를 반환
func move(current:Current,command:Command) -> Current {
    var newCurrent = current
    let allDirection = Direction.allCases
    let index = allDirection.firstIndex(of: current.d) ?? -1
    
    switch command {
    case .up:
         newCurrent.y -= 1
     case .down:
         newCurrent.y += 1
     case .left:
         newCurrent.x -= 1
     case .right:
         newCurrent.x += 1
    case .rotateClockwise:
        newCurrent.d = index == 3 ? .right:allDirection[index+1]
    case .rotateAntiClockwise:
        newCurrent.d = index == 0 ? .up:allDirection[index-1]
    case .rotateClockwise2:
        newCurrent = current2(current: current)
        newCurrent.d = index == 0 ? .up :allDirection[index-1]
    case .rotateAntiClockwise2:
        newCurrent = current2(current: current)
        newCurrent.d = index == 3 ? .right :allDirection[index+1]
    }
    return newCurrent
}

//이동한 위치가 가능한 위치인지 확인
func isEnabled(current:Current,b:[[Int]]) -> Bool {
    let second = current2(current: current)
    //현재 로봇이 지도 내에 있는지 확인
    if 0..<b.count ~= current.x && 0..<b.count ~= current.y && 0..<b.count ~= second.x && 0..<b.count ~= second.y {
        //현재 로봇이 있는 곳이 모두 0인지 확인
        if b[current.y][current.x] == 0 &&  b[second.y][second.x] == 0 {
            //현재 로봇이 있는 곳이 이미 지나간 곳이 아닌지 확인
            if !dontMove[current.d]![current.y][current.x] {
                //시계방향으로 회전했을 경우 각 현재 위치 맨하튼 거리가 0인지 확인
                if current.past == .rotateClockwise || current.past == .rotateClockwise2{
                    return b[current.y+clockManhattan[current.d]!.1][current.x+clockManhattan[current.d]!.0] == 0
                //반시계방향으로 회전했을 경우 각 현재 위치 맨하튼 거리가 0인지 확인
                }else if current.past == .rotateAntiClockwise || current.past == .rotateAntiClockwise2{
                    return b[current.y+antiClockManhattan[current.d]!.1][current.x+antiClockManhattan[current.d]!.0] == 0
                }else {
                    return true
                }
            }
        }
    }
    return false
}

//방향에 따라 두번째 로봇 위치 반환
func current2(current:Current) -> Current {
    var newCurrent = current
    newCurrent.x += directionXY[current.d]!.0
    newCurrent.y += directionXY[current.d]!.1
    return newCurrent
}
