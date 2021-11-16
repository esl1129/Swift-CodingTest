import Foundation

func solution(_ words:[String], _ queries:[String]) -> [Int] {
    var dic: [Int: Trie] = [:]
    var reverseDic: [Int: Trie] = [:]

    words.forEach { word in
        if dic[word.count] == nil {
            dic[word.count] = Trie()

            reverseDic[word.count] = Trie()
        }

        dic[word.count]?.insert(word)
        reverseDic[word.count]?.insert(String(word.reversed()))
    }

    var answer: [Int] = []
    queries.forEach { query in
        if query[query.startIndex] == "?" {
            if let reverseTrie = reverseDic[query.count] {
                let reverseQuery = String(query.reversed())
                answer.append(reverseTrie.search(reverseQuery))
            } else {
                answer.append(0)
            }
        } else {
            if let trie = dic[query.count] {
                answer.append(trie.search(query))
            } else {
                answer.append(0)
            }
        }
    }

    return answer
}

class Trie {
    var root: Nodes
    init() {
        root = Nodes(value: "")
    }
    func insert(_ word: String) {
        var curNode = root
        
        for char in word {
            curNode.count += 1
            if curNode.child[String(char)] == nil {
                curNode.child[String(char)] = Nodes(value: String(char))
            }
            
            curNode = curNode.child[String(char)]!
        }
    }
    
    func search(_ query: String) -> Int {
        var curNode = root
        for char in query {
            if char == "?" { return curNode.count }
            if curNode.child[String(char)] == nil { return 0 }
            
            curNode = curNode.child[String(char)]!
        }
        
        return curNode.count
    }
}

class Nodes {
    var value: String
    var count: Int
    var child: [String: Nodes]
    
    var isEmpty: Bool {
        return child.isEmpty
    }
    
    init(value: String) {
        self.value = value
        count = 0
        child = [:]
    }
}
