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

func champions(in array: [[String: Any]], forKey key: String) -> [[String: Any]] {
  array.filter { containsKey(key, in: $0) }
}

func containsKey(_ key: String, in array: [String: Any]) -> Bool {
  array["key"] as! String == key
}

func champName(at dictionary: [String: Any]) -> String {
  dictionary["name"] as! String
}

let champsArray = champs as! [[String: Any]]
let selectedIndexesArray = selectedIndexes as! [Int]

let names = selectedIndexesArray
  .flatMap { champions(in: champsArray, forKey: String($0)) }
  .map { champName(at: $0) }

print(names)
