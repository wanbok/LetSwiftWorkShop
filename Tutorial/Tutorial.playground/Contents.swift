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
struct Cham: Codable {
    var key: String
    var name: String
    var tags: [String]
}

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

let decoder = JSONDecoder()
if let champsData = champsData,
    let champsResponse = try? decoder.decode([Cham].self, from: champsData),
    let selectedIndexes = selectedIndexes as? [Int] {

    let value = selectedIndexes.map({ index in
        return champsResponse.first { (cham) -> Bool in
            return cham.key == "\(index)"
        }
    })

    let names: [String] = value.map({ $0?.name ?? "" })
    print("names: ", names)
}
