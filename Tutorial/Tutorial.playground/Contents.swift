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

//if let champs = champs as? [[String: Any]], let selectedIndexes = selectedIndexes as? [Int] {
//
//    let result = selectedIndexes.map { (index) -> [String] in
//        champs.filter { (dict) -> Bool in
//            return (dict["key"] as? String)?.elementsEqual("\(index)") ?? false
//        }.map({ cham in (cham["name"] as? String ?? "") })
//    }
//    print(result)
//}

let decoder = JSONDecoder()
if let champsData = champsData,
    let champsResponse = try? decoder.decode([Cham].self, from: champsData),
    let selectedIndexes = selectedIndexes as? [Int] {

    let name = selectedIndexes.compactMap({ "\($0)" })
        .flatMap { (index) -> [Cham] in champsResponse.filter({ $0.key.elementsEqual(index) }) }
        .map({ $0.name })

    print(name)

}
