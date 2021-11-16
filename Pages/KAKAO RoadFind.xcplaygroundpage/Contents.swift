import Foundation

public class Tree {
    var index: Int
    var location: [Int]
    var leftChild: Tree?
    var rightChild: Tree?
    weak var parents: Tree?
    
    init(_ info: EnumeratedSequence<[[Int]]>.Element) {
        self.index = info.offset+1
        self.location = info.element
    }
    
    func addChild(_ info: EnumeratedSequence<[[Int]]>.Element) {
        if  info.element[0] < location[0] {
            guard leftChild != nil else {
                leftChild = Tree(info)
                leftChild?.parents = self
                return
            }
            leftChild?.addChild(info)
        } else {
            guard rightChild != nil else {
                rightChild = Tree(info)
                rightChild?.parents = self
                return
            }
            rightChild?.addChild(info)
        }
    }
}

func preOrder(_ tree: Tree) -> [Int] {
    var result = [tree.index]
    if let leftChild = tree.leftChild {
        result.append(contentsOf: preOrder(leftChild))
    }
    if let rightChild = tree.rightChild {
        result.append(contentsOf: preOrder(rightChild))
    }
    return result
}

func postOrder(_ tree: Tree) -> [Int] {
    var result = [Int]()
    if let leftChild = tree.leftChild {
        result.append(contentsOf: postOrder(leftChild))
    }
    if let rightChild = tree.rightChild {
        result.append(contentsOf: postOrder(rightChild))
    }
    result.append(tree.index)
    return result
}

func solution(_ treeinfo:[[Int]]) -> [[Int]] {
    let sortedTreeInfos = treeinfo.enumerated().sorted{ $0.element[1] > $1.element[1] }
    let tree = Tree(sortedTreeInfos[0])
    
    for info in sortedTreeInfos.dropFirst() {
        tree.addChild(info)
    }
    
    var result = [[Int]]()
    result.append(preOrder(tree))
    result.append(postOrder(tree))
    
    return result
}
