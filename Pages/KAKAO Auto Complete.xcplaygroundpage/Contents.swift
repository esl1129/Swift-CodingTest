/*
func solution(_ words:[String]) -> Int {
    var answer = 0
    var wordDict: [String: [String]] = [:]
    
    for word in words{
        var newWord = word
        while newWord.count > 0{
            if wordDict[newWord] == nil{
                wordDict[newWord] = [word]
            }else{
                wordDict[newWord]!.append(word)
            }
            newWord.removeLast()
        }
    }
    for word in words{
        for i in 1...word.count{
            if i == word.count{
                answer += i
                break
            }
            var prestr = String(word.prefix(i))
            if wordDict[prestr]!.count == 1{
                answer += i
                break
            }
        }
    }
    return answer
}
 */

import Foundation

func solution(_ words:[String]) -> Int {
    let trie = Trie()
    var answer = 0

    words.forEach { word in
        trie.insert(word)
    }
    words.forEach { word in
        answer += trie.search(word)
    }
    return answer
}

class Trie {
    var root: Nodes
    
    init() {
        root = Nodes(depth: 0)
    }
    
    func insert(_ word: String) {
        var curNode = root
        for (index,char) in word.enumerated() {
            if curNode.child[String(char)] == nil {
                curNode.child[String(char)] = Nodes(depth: index+1)
            }
            curNode.value.append(word)
            curNode = curNode.child[String(char)]!
        }
        curNode.value.append(word)
    }
    
    func search(_ query: String) -> Int {
        var curNode = root
        for char in query {
            if curNode.value.count == 1 {return curNode.depth }
            
            curNode = curNode.child[String(char)]!
        }
        
        return curNode.depth
    }
}

class Nodes {
    var value: [String]
    var depth: Int
    var child: [String: Nodes]
    
    var isEmpty: Bool {
        return child.isEmpty
    }
    
    init(depth: Int) {
        self.value = []
        self.depth = depth
        child = [:]
    }
}

