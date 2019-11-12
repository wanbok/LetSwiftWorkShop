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

func getName(index: String) -> String? {
    return champs.filter { String(index) == $0.key}.first?.name
}


// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

let names: [String] = indexs.compactMap {getName(index: String($0))}
let names2: [String] = indexs.flatMap { (index) -> [String] in champs.filter { String(index) == $0.key}.map {$0.name}}
print(names)
print(names2)
