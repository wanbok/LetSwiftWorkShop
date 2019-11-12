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

let champs = try JSONSerialization.jsonObject(with: champsData!, options: []) as! [[String:Any]]
let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: []) as! [Int]

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
let names: [String] = selectedIndexes.map{ index -> String in
    let finded = champs.filter{$0["key"] as! String == index.description}.first ?? [:]
    return finded["name"] as! String
}

print(names)

//뭔가 순서가 이상하다
let names2: [String] = champs.map{($0["key"] ,$0["name"])}
    .compactMap { key, name -> String? in
        guard let key = key as? String, let idx = Int(key),
            selectedIndexes.contains(idx)  else { return nil }
        return name as? String
}

print(names2)
