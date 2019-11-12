import Foundation

struct Champ: Codable {
  let key: String
  let name: String
}

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

let champs = try JSONDecoder().decode([Champ].self, from: champsData!)
let selectedIndexes = try JSONDecoder().decode([Int].self, from: selectedIndexesData!)

let names: [String] = selectedIndexes.compactMap { index in
  champs.first { $0.key == "\(index)" }?.name
}
print(names)
