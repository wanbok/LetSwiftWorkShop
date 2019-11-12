import Foundation


// MARK: - Champ
struct Champ: Codable {
    let id, key, name, title: String
    let tags: [Tag]
    let stats: [String: Double]
    let icon: String
    let sprite: Sprite
    let champDescription: String

    enum CodingKeys: String, CodingKey {
        case id, key, name, title, tags, stats, icon, sprite
        case champDescription = "description"
    }
}

// MARK: - Sprite
struct Sprite: Codable {
    let url: String
    let x, y: Int
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}

typealias Champs = [Champ]

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

var names: [String] = []

let champsData = FileManager.default.contents(atPath: champsFilePath!)
let selectedIndexesData = FileManager.default.contents(atPath: selectedIndexesFilePath!)
if let data = champsData {
  let champs = try? JSONDecoder().decode(Champs.self, from: data)
  let selectedIndexes = try JSONSerialization.jsonObject(with: selectedIndexesData!, options: []) as? [Int]
  
  selectedIndexes?.forEach({ num in
    champs?.forEach({ (champ) in
      if champ.key == String(num) {
        names.append(champ.name)
      }
    })
  })
  
//  champs?.forEach({ champ in
//    selectedIndexes?.forEach({ (num) in
//      if champ.key == String(num) {
//        names.append(champ.name)
//      }
//    })
//  })
}

// TODO: selectedIndexes는 챔피언 목록(champs)의 key 번호 들이다. selectedIndexes에 명시된 순서대로 챔피언들의 이름(name)을 나열하라

print(names)
