struct Car {
    var row:Int,col:Int,price:Int,prev:Direction
}

enum Direction {
    case west,east,north,south
}

func solution(_ board:[[Int]]) -> Int {
    var visited:[[Int]] = Array(repeating: Array(repeating:Int.max, count: board.count), count: board.count)
    moveFourDirection(car: Car(row: 0, col: 1, price: 100, prev:.east),board: board,visited: &visited)
    moveFourDirection(car: Car(row: 1, col: 0, price: 100, prev:.south),board:board,visited: &visited)
    return visited.last!.last!
}

func moveFourDirection(car:Car,board:[[Int]],visited:inout [[Int]]) {
    let direction:[Direction:(Int,Int)] = [.east:(0,1),.west:(0,-1),.south:(1,0),.north:(-1,0)]
    if isPossible(car: car, board: board, visited: visited) {
        visited[car.row][car.col] = car.price
        for (key,value) in direction {
            var newCar = Car(row: car.row + value.0, col: car.col+value.1, price: car.price, prev: key)
            newCar.price += car.prev == key ? 100 : 600
            moveFourDirection(car: newCar, board: board, visited: &visited)
        }
    }
}

func isPossible(car:Car,board:[[Int]],visited:[[Int]]) -> Bool {
    return 0..<board.count ~= car.row && 0..<board.count ~= car.col && car.price <= visited[car.row][car.col] && board[car.row][car.col] == 0
}
