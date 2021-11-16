 import Foundation

 func solution(_ info:[String], _ query:[String]) -> [Int] {
    var answer: [Int] = []
    var database: [String:[Int]] = [ : ]
    
     for person in info{
         let p = person.components(separatedBy: " ")
         let language = [p[0],"-"]
         let task = [p[1], "-"]
         let career = [p[2], "-"]
         let food = [p[3],"-"]
         let score = Int(p[4])!
        
         for lan in language{
            for t in task{
                for c in career{
                    for f in food{
                        let key = "\(lan)\(t)\(c)\(f)"
                         if database[key] == nil{
                             database[key] = [score]
                         }else{
                             database[key]!.append(score)
                         }
                    }
                }
            }
         }
     }
        
     for db in database{
         let sort = db.value.sorted()
         database[db.key] = sort
     }
        
     for q in query {
         let arr = q.components(separatedBy: " ")
         let key = "\(arr[0])\(arr[2])\(arr[4])\(arr[6])"
         let score = Int(arr[7])!
        
         if let scoreArr = database[key]{
             var low = 0
             var high = scoreArr.count-1
             var mid = 0
                
             while low <= high{
                 mid = (low+high)/2
                 if scoreArr[mid] < score{
                     low = mid + 1
                 }else{
                     high = mid - 1
                 }
             }
             answer.append(scoreArr.count-low)
         }else{
             answer.append(0)
         }
            
     }
     return answer
 }

 //============================================================================
import Foundation

func solution(_ info:[String], _ query:[String]) -> [Int] {
    var db: [String : [Int]] = [ : ]
    var result: [Int] = []

    // db 생성
    for i in info {
        let arr = i.components(separatedBy: " ")
        let languages = [arr[0], "-"]
        let jobs = [arr[1], "-"]
        let careers = [arr[2], "-"]
        let soulFoods = [arr[3], "-"]
        let score = Int(arr[4])!

        for language in languages{
            for job in jobs{
                for career in careers {
                    for soulFood in soulFoods {
                        let key = "\(language)\(job)\(career)\(soulFood)"
                        if db[key] == nil {
                            db[key] = [score]
                        } else {
                            db[key]?.append(score)
                        }
                    }
                }
            }
        }
    }

    // 이진탐색을 위해 오름차순 정렬
    let dbCnt = db.count
    for i in db{
        let sortArr = i.value.sorted()
        db[i.key] = sortArr
    }

    // 마지막 score 비교
    for i in query{
        let arr = i.components(separatedBy: " ")
        let key = "\(arr[0])\(arr[2])\(arr[4])\(arr[6])"
        let score = Int(arr[7])!

        if let scoreArr = db[key]{
            // 이진 탐색
            var low = 0
            var high = scoreArr.count - 1
            var mid = 0

            while low <= high {
                mid = (low + high) / 2
                if scoreArr[mid] < score {
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
            result.append(scoreArr.count - low)
        } else{
            result.append(0)
        }
    }
    
    for q in query {
        let arr = q.components(separatedBy: " ")
        let key = "\(arr[0])\(arr[2])\(arr[4])\(arr[6])"
        let score = Int(arr[7])!
       
        if let scoreArr = database[key]{
            var low = 0
            var high = scoreArr.count-1
            var mid = 0
               
            while low <= high{
                mid = (low+high)/2
                if scoreArr[mid] < score{
                    low = mid + 1
                }else{
                    high = mid - 1
                }
            }
            answer.append(scoreArr.count-low)
        }else{
            answer.append(0)
        }
           
    }
    
    return result
}
