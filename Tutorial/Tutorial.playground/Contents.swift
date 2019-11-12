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

let champs = try JSONSerialization.jsonObject(with: champsData!, options: []) as? [[String: Any]]
let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: []) as? [Int]

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
let names = selectedIndexes?
    .compactMap { String($0) }
    .compactMap { index in
        champs?.first { $0["key"] as? String == index }
    }
    .compactMap { $0["name"] as? String }
    ?? []

print(names)

// 코드는 깔끔해 졌으나 챔프를 탐색할 때 중복하여 탐색하게 되는 문제가 있다.
// 딕셔너리 배열이 아닌 딕셔너리로 탐색하면 비효율을 줄일 수 있을 것 같다.
// 딕셔너리 배열을 딕셔너리로 변경하려면 어떻게 해야 할까?
// 함수형으로 깔끔하게 변경하는 법을 좀 더 고민해야 겠다.
