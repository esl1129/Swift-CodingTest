import Foundation

func solution(_ arrows:[Int]) -> Int {

    var Point_Visited_Set: Set<Point> = [Point(x: 0,y: 0)]
    var Edge_Visited_Dict: [Point: [Int]] = [:]
    var answer = 0
    var currentPoint = Point(x: 0, y: 0)

    arrows.forEach { arrow in
        let originPoint = currentPoint
        currentPoint = originPoint.move(arrow)
        let point: (Point, Int) = arrow < 4 ? (originPoint, arrow) : (currentPoint, arrow-4)
        
        if Edge_Visited_Dict[point.0]?.contains(point.1) ?? false { return }

        if point.1 % 2 == 1{
            let crossCheck = (point.1 == 1)
                ? Edge_Visited_Dict[point.0.move(0)]?.contains(3) ?? false
                : Edge_Visited_Dict[point.0.move(4)]?.contains(1) ?? false
            
            if crossCheck { answer += 1 }
        }

        if Point_Visited_Set.contains(currentPoint) { answer += 1 }
        Point_Visited_Set.insert(currentPoint)
        
        if Edge_Visited_Dict[point.0] != nil {
            Edge_Visited_Dict[point.0]!.append(point.1)
        }else {
            Edge_Visited_Dict[point.0] = [point.1]
        }
    }

    return answer
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    static let dir = [(0,-1), (1,-1), (1,0), (1,1), (0,1), (-1,1), (-1,0), (-1,-1)]

    func move(_ arrow: Int) -> Point {
        return Point(x: x + Point.dir[arrow].0, y: y + Point.dir[arrow].1)
    }
}
