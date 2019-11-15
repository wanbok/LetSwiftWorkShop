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
var names: [String] = []
print(names)

struct Champ: Codable{
    let key: String
    let name: String
}

let champArr = try JSONDecoder().decode([Champ].self, from: champsData!)
let select = try JSONDecoder().decode([Int].self, from: selectedIndexesData!)

//["Tryndamere", "Udyr", "Ahri", "Vayne", "Pyke"]
select.forEach{ index in
    champArr
        .filter{ "\(index)" == $0.key }
        .compactMap{ names.append($0.name) }
}

/*
select.compactMap{ key in
    champArr
        .first{ $0.key == "\(key)" }
        .flatMap{ names.append($0.name) }
}
 */
//위와같은 상황일경우 forEach와 compactMap의 동작은 같은가 성능은 어느것이 좋은가?

//아래같은경우는 select순서대로 검색불가
champArr.compactMap{ champ in
    select.filter{ champ.key == "\($0)" }.map{ _ in
        names.append( champ.name ) }
}



print(names)
