import Foundation

var cardCombination: [[Int]] = []
var cardsType:[Int] = []
var Dict: [Int: [Int]] = [:]
func solution(_ board:[[Int]], _ r:Int, _ c:Int) -> Int {
    for i in 0..<4{
        for j in 0..<4{
            if board[i][j] != 0{
                if !cardsType.contains(board[i][j]){
                    cardsType.append(board[i][j])
                }
                if Dict[board[i][j]] == nil{
                    Dict[board[i][j]] = [i]
                    Dict[board[i][j]]!.append(j)
                }else{
                    Dict[board[i][j]]!.append(i)
                    Dict[board[i][j]]!.append(j)
                }
            }
        }
    }
    suffle(card: [], count: cardsType.count)
    print(Dict)
    return 0
}

func suffle(card: [Int], count: Int){
    if card.count == count{
        cardCombination.append(card)
        return
    }
    for c in cardsType{
        if !card.contains(c){
            var newCard = card
            newCard.append(c)
            suffle(card: newCard, count: count)
        }
    }
}
