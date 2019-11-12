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

let tempChamps = champs as! [[String: Any]]
let tempIndexs = selectedIndexes as! [Int]

names = tempChamps.filter({ (champs) -> Bool in
    return tempIndexs.reduce(false) { (result, key) -> Bool in
        return !result ? (champs["key"] as! String) == String(key) : result
    }
}).map {
    return $0["name"] as! String
}

print(names)
