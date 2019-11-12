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

let champList = (champs as? [[String: Any]]) ?? []
let selectedIndexList = ((selectedIndexes as? [Int]) ?? []).compactMap { String($0) }

let temp: [[String: String]] = champList
    .map {
        guard let key = $0["key"] as? String, let name = $0["name"] as? String else { return nil }
        return ["key": key, "name": name]
    }
    .compactMap { $0 }

selectedIndexList.forEach { index in
    let value = temp
        .filter { $0["key"] == index }
        .compactMap { $0 }
        .first
    
    names.append((value?["name"] as? String) ?? "")
}

print(names)
