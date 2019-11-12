import Foundation
struct Champ: Codable {
    var key: String
    var name: String
}
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

//let champs = try JSONSerialization.jsonObject(with: champsData!, options: [])
let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: [])
let indexs = selectedIndexes as! [Int]
let champs = try JSONDecoder().decode([Champ].self, from: champsData!)

func getName(str: String) -> String? {
    
   
    for champ in champs {
        let key = champ.key
        if key == str {
            return champ.name
        }
    }
    return nil
}
func getName2(str: String) -> [String] {
    
   return champs.filter { str == $0.key}.map {$0.name}
    
}

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

let names: [String] = indexs.compactMap {getName(str: String($0))}
let names2: [String] = indexs.flatMap { (index) -> [String] in
    getName2(str: String(index))
}
print(names)
print(names2)
