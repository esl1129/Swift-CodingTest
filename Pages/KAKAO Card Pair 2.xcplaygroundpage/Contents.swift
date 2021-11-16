func solution(_ board:[[Int]], _ r:Int, _ c:Int) -> Int { // card 위치 저장
    var info: [Int: [(Int, Int)]] = [:]
    for i in 0..<4 {
        for j in 0..<4 {
            let card = board[i][j]
            if card != 0 {
                if info[card] == nil {
                    info[card] = [(i, j)]
                    
                } else {
                    info[card]?.append((i, j))
                    
                }
                
            }
            
        }
        
    }
    
    // 1. 카드 제거 순서
    let cards = info.keys.map{ $0 }
    var combinations: [[Int]] = []
    var visited: [Int] = Array(repeating: 0, count: cards.count)
    
    func permutation(depth: Int, size: Int, path: [Int]) {
        if depth == size {
            combinations.append(path)
            return
        }
        
        var path = path
        for i in 0..<size {
            if visited[i] == 0 {
                visited[i] = 1
                path.append(cards[i])
                permutation(depth: depth + 1, size: size, path: path)
                path.removeLast()
                visited[i] = 0
            }
        }
    }
    
    permutation(depth: 0, size: cards.count, path: [])
    
    // 2. 한 쌍에서 어떤 카드부터 방문할 건지 결정
    var paths: [[(Int, Int)]] = []
    
    func makePath(_ idx: Int, _ path: [(Int, Int)], _ combination: [Int]) {
        if idx == combination.count {
            paths.append(path)
            return
            
        }
        
        var path = path
        guard let card = info[combination[idx]] else { return }
        path.append(card[0])
        path.append(card[1])
        makePath(idx+1, path, combination)
        path.removeLast()
        path.removeLast()
        path.append(card[1])
        path.append(card[0])
        makePath(idx+1, path, combination)
        path.removeLast()
        path.removeLast()
        
    }
    
    for combination in combinations {
        makePath(0, [], combination)
        
    }
    
    // 3. bfs
    
    func isRange(_ x: Int, _ y: Int) -> Bool {
        return x >= 0 && x < 4 && y >= 0 && y < 4
    }
    
    func findNext(_ dir: Int, _ x: Int, _ y: Int) {
        
    }
    
    func bfs() { }
    
    return 0
}

