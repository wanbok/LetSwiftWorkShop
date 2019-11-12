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

let names: [String] = selectedIndexes.map {
    String(describing: $0)
}.compactMap { key in
    champs.first { $0.key == key }?.name
}
print(names)

