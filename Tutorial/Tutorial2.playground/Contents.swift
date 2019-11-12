import Foundation

struct Champ: Decodable {
    let key: String
    let name: String
}


let champsFilePath = Bundle.main.path(forResource: "champs", ofType: "json")

let selectedIndexesFilePath = Bundle.main.path(forResource: "selectedIndexes", ofType: "json")

let champsData = FileManager.default.contents(atPath: champsFilePath!)
let selectedIndexesData = FileManager.default.contents(atPath: selectedIndexesFilePath!)

let decoder = JSONDecoder()
let champs = try decoder.decode([Champ].self, from: champsData!)
let selectedIndexes = try decoder.decode([Int?].self, from: selectedIndexesData!)

extension Array where Element: Equatable {
    func uniqueMap() -> Self {
        return self.reduce([Element]()) {
            return !$0.contains($1) ? ($0 + [$1]) : $0
        }
    }
}

let names: [String] = selectedIndexes
    .uniqueMap()
    .compactMap { $0 }
    .map {
        String(describing: $0)
    }
    .compactMap { key in
        champs.first { $0.key == key }?.name
    }
print(names)



