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

class Champion: Codable {
    var key: String?
    var name: String?
}

let champs = try! JSONDecoder().decode([Champion].self, from: champsData!)
let indexes = try! JSONDecoder().decode([Int].self, from: selectedIndexesData!)

//let numberIndexes = indexes.map{ Int($0)! }

var names: [String] = []

indexes.forEach { index in
    champs.filter { champ in
        champ.key == String(index)
    }.map { names.append($0.name!) }
}

// ["Tryndamere", "Udyr", "Ahri", "Vayne", "Pyke"]
print(names)

//names = indexes.map { index in
//    champs.filter { champ in
//        champ.key == index
//    }
//}

