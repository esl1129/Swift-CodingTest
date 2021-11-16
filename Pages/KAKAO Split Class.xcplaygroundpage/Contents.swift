import Foundation

var maps = [[Int]]()
var tree = [[Int]]()
var globalNum = [Int]()
var cnt = 0

func solution(_ k:Int, _ num:[Int], _ links:[[Int]]) -> Int {
    let size = links.count
    maps = [[Int]](repeating: [], count: size)
    tree = [[Int]](repeating: [], count: size)
    var check = [Bool](repeating: false, count: size)
    globalNum = num
    for (idx, link) in links.enumerated(){
        if link[0] != -1{
            check[link[0]] = true
            maps[idx].append(link[0])
            maps[link[0]].append(idx)
        }
        if link[1] != -1{
            check[link[1]] = true
            maps[idx].append(link[1])
            maps[link[1]].append(idx)
        }
    }
    
    let root = check.firstIndex(of: false)!
    makeTree(-1,root)
    var rt = num.reduce(0,+)
    var lt = num.max()!
    
    while lt <= rt{
        let mid = (lt+rt)/2
        find(root,mid)
        if cnt >= k{
            lt = mid + 1
        }else{
            rt = mid - 1
        }
        cnt = 0
    }
    return rt+1
}

func makeTree(_ prev: Int, _ now: Int){
    for c in maps[now]{
        if c != prev{
            tree[now].append(c)
            makeTree(now,c)
        }
    }
}

func find(_ idx: Int, _ mid: Int) -> Int{
    if tree[idx].isEmpty{
        return globalNum[idx]
    }
    let l = find(tree[idx][0], mid)
    let r = tree[idx].count == 1 ? 0 : find(tree[idx][1],mid)
    
    if l+r+globalNum[idx] <= mid{
        return l+r+globalNum[idx]
    }
    cnt += 1
    let min = l <= r ? l : r
    if min + globalNum[idx] > mid{
        cnt += 1
        return globalNum[idx]
    }
    return globalNum[idx] + min
}
