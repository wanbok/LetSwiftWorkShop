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
struct ReturnedData {
    let name: String
}
let champs = try JSONSerialization.jsonObject(with: champsData!, options: [])

let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: [])

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

var names: [String] = []

if let typedChamps = champs as? [[String: Any]] {
    if let indexes = selectedIndexes as? [Int] {
        
        let extractedNames = typedChamps
            .filter { champ in
                return indexes.contains(Int(champ["key"] as! String)!)
            }.map { champ in
                return champ["name"] as! String
            }.reduce
        names.append(contentsOf: extractedNames)
    }
}

print(names)
