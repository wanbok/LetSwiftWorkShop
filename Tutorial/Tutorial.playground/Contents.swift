import Foundation


struct Champ: Codable {
    var id: String
    var key: String
    var name: String
    var title: String
    //    var tag: [String]
    //
    //    var stats: Stats
    //    var icon: String
    //    var sprite: Sprite
    //
    //    var description: String
}
//struct Stats: Codable {
//
//    var hp: Double
//    var hpperlevel: Double
//    var mp: Double
//    var mpperlevel: Double
//    var movespeed: Double
//    var armor: Double
//    var armorperlevel:Double
//    var spellblock: Double
//    var spellblockperlevel: Double
//    var attackrange: Double
//    var hpregen: Double
//    var hpregenperlevel: Double
//    var mpregen: Double
//    var mpregenperlevel: Double
//    var crit: Double
//    var critperlevel: Double
//    var attackdamage: Double
//    var attackdamageperlevel: Double
//    var attackspeedoffset: Double
//    var attackspeedperlevel: Double
//
//}
//struct Sprite: Codable {
//    var url: String
//    var x: Double
//    var y: Double
//
//}

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

let selectedIndexesFilePath = Bundle.main.path(forResource: "selectedIndexes", ofType: "json")

let champsData = FileManager.default.contents(atPath: champsFilePath!)
let selectedIndexesData = FileManager.default.contents(atPath: selectedIndexesFilePath!)

let champs = try JSONSerialization.jsonObject(with: champsData!, options: [])

let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: [])

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

let selectedKeys = (selectedIndexes as? [Any] ?? []).reduce(into: [String]()) { (inoutData, anyData) in
    if let intKey = anyData as? Int {
        inoutData.append(String(intKey))
    }
}
 

let decoder = JSONDecoder()
if let data = champsData, let existChampsData = try? decoder.decode([Champ].self, from: data) {
    let dictionaryData = existChampsData.reduce(into: [String:Champ]() ) { (outData, champData) in
        outData[champData.key] = champData
    }
    selectedKeys.forEach{ key in
        if let existData = dictionaryData[key] {
            print(existData)
        }
    }
}
//



