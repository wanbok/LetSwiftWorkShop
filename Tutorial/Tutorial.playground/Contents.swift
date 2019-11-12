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
let champsArray = champs as? [[String:Any]]
let indexesArray = selectedIndexes as? [Int]

var names: [String] = []

indexesArray?.compactMap{ key in
//    let champ = champsArray?.filter {
//        $0["key"] as? String == "\(key)"
//    }
//
//    champ?.forEach {
//        names.append($0["name"] as? String ?? "")
//    }
    
    champsArray?.filter { $0["key"] as? String == "\(key)" }
        .forEach { names.append($0["name"] as? String ?? "")
    }
}

print(names)
