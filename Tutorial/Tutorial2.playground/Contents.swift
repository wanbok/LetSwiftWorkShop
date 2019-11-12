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
let names: [String] = []
print(names)

if let champsArray = champs as? Array<Dictionary<String, Any>>, let selectedIndexesArray = selectedIndexes as? Array<Any> {
    
    print(
        selectedIndexesArray.compactMap { (index) -> String? in
            guard let index = index as? Int else { return nil }
            guard champsArray.count > index else { return nil }
            
            return String(index)
            }
            //        .flatMap{$0}
            .compactMap ({ (key) -> Dictionary<String, Any>? in
                return champsArray.first(where: { (champ) -> Bool in
                    guard let champKey = champ["key"] as? String else { return false }
                    return champKey == key
                })
            }).compactMap { (obj) -> String? in
                
                return obj["name"] as? String
        }
        
    )
    
    
    
}
