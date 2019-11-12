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

let champDicts = (champs as? [[String: Any]])?
    .compactMap { $0 }
    .map { ($0["key"] as! String, $0["name"] as! String) }
    .reduce([:], { (res, current) -> [String: String] in
        var res = res
        res[current.0] = current.1
        return res
    })

if let selectedIndexes = selectedIndexes as? [Int?],
    let champDicts = champDicts {
    
    let result = selectedIndexes
        .compactMap { $0 }
        .map { "\($0)" }
        .map { champDicts[$0] }
        .compactMap { $0 }
    
    print(result)
}

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
let names: [String] = []
print(names)

