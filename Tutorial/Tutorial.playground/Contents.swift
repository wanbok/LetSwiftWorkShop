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

struct Champ: Decodable {
    let key: String
    let name: String
}

func merge(to dict: inout [String: String], from champ: Champ) {
    dict[champ.key] = champ.name
}

func champName(at key: Int) -> String? {
    return champDict["\(key)"]
}

let champs = try JSONDecoder().decode([Champ].self, from: champsData ?? Data())
let selectedIndexes = try JSONDecoder().decode([Int].self, from: selectedIndexesData ?? Data())

let champDict = champs
    .reduce(into: [:], merge)
// 처음엔 Champ의 init에서 Dictionary로 정보를 받아 처리해 주도록 하여 개선해 보았으나 고계함수의 활용과 거리가 멀어보여 JSONDecoder를 활용하여 개선하도록 수정하였다.

let names = selectedIndexes
    .compactMap(champName)
// Int를 String으로 변환해 주던 함수를 생략하였다.
// Int를 String으로 변환해 줄 뗀 옵셔널 타입이 아니라 compactMap을 사용할 필요가 없다.

print(names)

// JSONDecoder를 활용하여 처리하도록 변경하였다.
// 그리고 익명함수를 안쓰고 적용할 수 있도록 변경해 보았다.
