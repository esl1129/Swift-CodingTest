import Foundation

struct Page {
    var index:Int, url:String,score:Double,externalLinks:[String]
}

func solution(_ word:String, _ pages:[String]) -> Int {
    
    var pageInfos:[Page] = []
    for (i,page) in pages.enumerated() {
        var pageInfo = Page(index:i,url: "", score: 0, externalLinks: [])
        let tags = page.split(separator: "<")
        var score:Double = -1
        
        for tag in tags {
            if String(tag.prefix(6)) == "meta p" {
                pageInfo.url = getWebpageURL(tag: String(tag))
            }
            if String(tag.prefix(5)) == "/body" {
                pageInfo.score = score
                break
            }
            if String(tag.prefix(6)) == "a href" {
                let url = tag.split(separator: "\"")[1]
                pageInfo.externalLinks.append(String(url))
            }
            if String(tag.prefix(4)) == "body" {
                score += 1
            }
            if score > -1 {
                findWordInBody(tag: String(tag), word: word.lowercased(), score: &score)
            }
        }
        pageInfos.append(pageInfo)
    }
    
    return getMaxMatchingScoreIndex(pageInfos: &pageInfos)
}
func getWebpageURL(tag:String) -> String {
    let content = tag.split(separator: " ").last!
    return String(content.split(separator: "\"")[1])
}

func findWordInBody(tag:String,word:String,score:inout Double) {
    let contains = tag.split(separator: " ").filter{$0.lowercased().contains(word)}
    for contain in contains {
        let new = contain.map{$0.isLetter ? String($0.lowercased()) : " "}.joined().split(separator: " ")
        score += Double(new.filter{$0 == word}.count)
    }
}

func getMaxMatchingScoreIndex(pageInfos:inout [Page]) -> Int {
    for pageInfo in pageInfos {
        for link in pageInfo.externalLinks {
            if let index = pageInfos.firstIndex(where: {$0.url == link}) {
                pageInfos[index].score += pageInfo.score/Double(pageInfo.externalLinks.count)
            }
        }
    }
    return pageInfos.sorted{($0.score) > ($1.score)}.first?.index ?? 0
}
