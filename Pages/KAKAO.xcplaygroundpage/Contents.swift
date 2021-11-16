import Foundation




// KAKAO 1.
func solution(_ id_list: [String], _ report:[String], _ k:Int) -> [Int]{
    var dict = [String : [String]]()
    var banned = [String: Int]()
    var answer = [Int](repeating: 0, count: id_list.count)
    for r in report{
        var split = r.split(separator: " ")
        if dict[String(split[0])] == nil{
            dict[String(split[0])] = [String(split[1])]
            if banned[String(split[1])] == nil{
                banned[String(split[1])] = 1
            }else{
                banned[String(split[1])]! += 1
            }
        }else{
            if !dict[String(split[0])]!.contains(String(split[1])){
                dict[String(split[0])]!.append(String(split[1]))
                if banned[String(split[1])] == nil{
                    banned[String(split[1])] = 1
                }else{
                    banned[String(split[1])]! += 1
                }
            }
        }
    }
    
    for ban in banned{
        if ban.value >= k{
            for dic in dict{
                if dic.value.contains(ban.key){
                    answer[id_list.firstIndex(of: dic.key)!] += 1
                }
            }
        }
    }
    
    return answer
}

//KAKAO 2.
func solution(_ id_list: [String], _ report:[String], _ k:Int){

}
