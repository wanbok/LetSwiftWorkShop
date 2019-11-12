import Foundation

/*
 [
    {
        "key": "266",
        "name": "Aatrox",
    ...
    },
    ...
 ]
 */
let champsFilePath = Bundle.main.path(forResource: "champs", ofType: "json")

/*
 [
    1,
    33,
    ...
 ]
 */
let selectedIndexesFilePath = Bundle.main.path(forResource: "selectedIndexes", ofType: "json")

let champsData = FileManager.default.contents(atPath: champsFilePath!)
let selectedIndexesData = FileManager.default.contents(atPath: selectedIndexesFilePath!)

let champs = try JSONSerialization.jsonObject(with: champsData!, options: [])
let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: [])

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
var names: [String] = []

struct Chmaps {
    let key: String
    let name: String
    
    init(json: [String: Any]) {
        key = json["key"] as? String ?? ""
        name = json["name"] as? String ?? ""
        
    }
}

let champArr = champs as! [Any]
let champsDatas = champArr.map{Chmaps(json: $0 as! [String : Any])}

let selectedIndexesArr = selectedIndexes as! [Int]
print(selectedIndexesArr)

//forEach, filter, first/last(where:), reduce
//map, flatMap, compactMap

// MARK: 실습

selectedIndexesArr.forEach { (key) in
    let filteringChamps = champsDatas.filter({ (champ) -> Bool in
        let result = champ.key == String(key)
        return result
    })
    filteringChamps.forEach{names.append($0.name)}
    
    
}
print(names)


// MARK: 실습1. 고계함수 활용
//forEach, filter, first/last(where:), reduce
//map, flatMap, compactMap

let result = selectedIndexesArr.map { (key) -> String in
    champsDatas.first { (champ) -> Bool in
       return champ.key == String(key)
        }.map{$0.name} ?? ""
}

print(result)
  











