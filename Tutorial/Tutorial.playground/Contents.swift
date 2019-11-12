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

struct Champs:Decodable {
    let key: String
    let name: String
}

let decoder = JSONDecoder()
let champs = try decoder.decode([Champs].self, from: champsData!)
let selected = try decoder.decode([Int].self, from: selectedIndexesData!)

var index = 0
var block: (Champs) -> (Void)
//block = { champs in
//    if Int(champs.key) == selected[index] {
//        print(champs.name)
//    }
//    if selected.count > index {
//        index += 1
//    }
//}
//
print(champs)

let value = selected.flatMap { index in
    champs.filter { champ in
        champ.key == "\(index)"
    }
}
let names = value.map{$0.name}
print(names)


// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라
//let names: [String] = []
//print(names)


//selectedIndex대로 챔프 이름을 배열로 불러오면 된다. 챔피언명 5개가 옆에 뜨면 된다.
