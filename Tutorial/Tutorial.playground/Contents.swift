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
let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: []) as! [Int]
//구현
struct Champion: Codable {
    let key: String
    let name: String
}

let champions = try! JSONDecoder().decode([Champion].self, from: champsData!).sorted(by: { (left, right) -> Bool in
    return Int(left.key)! < Int(right.key)!
}).filter({ champion -> Bool in
    selectedIndexes.contains(Int(champion.key)!)
})

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

let names: [String] = champions.map { champion -> String in
    return champion.name
}
print(names)
