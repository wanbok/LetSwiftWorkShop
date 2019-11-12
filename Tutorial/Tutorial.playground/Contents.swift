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

let champsDict = champs?
    .flatMap { [($0["key"] as? String) ?? "": ($0["name"] as? String) ?? ""] }
    .reduce(into: [String: String](), { $0[$1.key] = $1.value })

let names = selectedIndexes?
    .compactMap { String($0) }
    .compactMap { champsDict?[$0] }
    ?? []

print(names)

// flatMap과 reduce를 이용하여 딕셔너리 배열을 딕셔너리로 변경하였다.
// 그 결과 결과값을 바로 캐스팅하여 가져올 수 있게 되었다.
// 이전 코드 보단 한층 깔끔한 느낌이다.
// 다만 flatMap으로 튜플로 변경하는 부분의 코드가 가독성이 좋지 않고 지저분하다.
// 저것도 더 깔끔하게 변경할 수 있을지 고민해 봐야 겠다.
