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
var names: [String] = []

let champsJson = champs as! [[String : Any]]
let indexesArray: [String] = (selectedIndexes as! [Int]).map { number in
    number.description
}

indexesArray.forEach { value in
    
    let filteredChamps = champsJson.filter { dict in
        guard let dictValue = dict["key"] as? String else { return false }
        return dictValue == value
    }
    
    guard
        let filteredChamp = filteredChamps.first,
        let champName = filteredChamp["name"] as? String else { return }
    
    names.append(champName)
}

print("Result: \(names)")
