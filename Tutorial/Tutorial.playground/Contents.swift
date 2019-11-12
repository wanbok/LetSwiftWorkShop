import Foundation

struct Champ: Codable {
    let name: String
    let id: String
    let key: String
    let title: String
    let tags: Array<String>
//    let stats: Stats
    let icon: String
//    let sprite: Sprite
    let description: String
}

extension Champ {
    struct Stats: Codable {
        let hp: Int
        let hpperlevel: Int
        let mp: Int
        let mpperlevel: Int
        let movespeed: Int
        let armor: Int
        let armorperlevel: Float
        let spellblock: Float
        let spellblockperlevel: Float
        let sttackrange: Int
        let hpregen: Float
        let hpregenperlevel: Float
        let mpregen: Int
        let mpregenperlevel: Int
        let crit: Int
        let critperlevel: Int
        let attackdamage: Int
        let attackdamageperlevel: Float
        let attachspeedoffset: Float
        let attachsppedperlevel: Int
    }

    struct Sprite: Codable {
        let url: String
        let x: Int
        let y: Int
    }
}

let champsFilePath = Bundle.main.path(forResource: "champs", ofType: "json")
let selectedIndexesFilePath = Bundle.main.path(forResource: "selectedIndexes", ofType: "json")

let champsData = FileManager.default.contents(atPath: champsFilePath!)
let selectedIndexesData = FileManager.default.contents(atPath: selectedIndexesFilePath!)

//let champs = try JSONSerialization.jsonObject(with: champsData!, options: [])
var indices: Array<Int> = []
if let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: []) as? Array<Int> {
    indices = selectedIndexes
}

let champs: Array<Champ> = try! JSONDecoder().decode(Array<Champ>.self, from: champsData!)
let names = indices
    .compactMap { index in champs.first { Int($0.key)! == index } }
    .map { champ in champ.name }

print(names)
