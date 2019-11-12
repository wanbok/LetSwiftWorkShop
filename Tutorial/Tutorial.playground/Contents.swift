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

struct Champ: Decodable {
    let key: String
    let name: String
}


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

let decoder = JSONDecoder()
let champs = try decoder.decode([Champ].self, from: champsData!)
let selectedIndexes = try decoder.decode([Int].self, from: selectedIndexesData!)

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

let dictionary = champs.reduce(into: [String: String]()) {
    $0[$1.key] = $1.name
}
let names = selectedIndexes.map {
    String(describing: $0)
}.compactMap {
    dictionary[$0]
}
print(names)
