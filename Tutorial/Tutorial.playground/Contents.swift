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
    for json in champs {
        let key = json.key
        if key == str {
            return json.name
        }
    }
    return nil
}

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
let names: [String] =  indexs.map { (index) -> String in
    let num = String(index)
    return getName(str: num)!
}
print(names)
