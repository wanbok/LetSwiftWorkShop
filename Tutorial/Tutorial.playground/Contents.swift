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

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

typealias ChampHashMap = [String: String]

extension ChampHashMap {
    func name<T: LosslessStringConvertible>(at key: T) -> String? {
        return self[String(key)]
    }
}

struct Champ: Decodable {
    let key: String
    let name: String
}

func merge(to hashMap: inout ChampHashMap, from champ: Champ) {
    hashMap[champ.key] = champ.name
}

let champs = try JSONDecoder().decode([Champ].self, from: champsData ?? Data())
let selectedIndexes = try JSONDecoder().decode([Int].self, from: selectedIndexesData ?? Data())

let champHashMap = champs
    .reduce(into: [:], merge)

let names = selectedIndexes
    .compactMap(champHashMap.name)

print(names)

// 함수 내부에서 함수 밖의 프로퍼티에 접근 하는 것은 위험하다고 생각되어 ChampHashMap 타입을 정의하고 ChampHashMap을 확장하여 이름을 리턴하도록 변경하였다.
// hashMap이 dictionary보다 의도가 잘 드러날 거라 기대하여 변경하였다.
