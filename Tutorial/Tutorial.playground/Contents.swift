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
var allInfo = [String: String]()

// dic? map?
// BST

var champInfoArr = [(Int, String)]()

if let champsArr = champs as? [Any] {
//  print(champsArr)
  for champ in champsArr {
    if let champInfo = champ as? [String: Any] {
//      print(champInfo)
      if let name = champInfo["name"] as? String {
//        print(name)
        if let key = champInfo["key"] as? String {
//            print("\(name), \(key)")

          allInfo[key] = name
        }
        
      }
    }
  }
}

//print(allInfo[555])

if let arr = selectedIndexes as? [Any]{
  for ele in arr {
    if let num = ele as? Int {
      // as? String 하면 왜 안되는걸까?
      // 그래서 Int로 casting 하고 key를 만들었다.
      let key = "\(num)"
      if let ans = allInfo[key] {
          print(ans)
      }
    }
  }
}

//
//func getInfo(_ champs: Any) -> [(Int, String)] {
//  var champInfoArr = [(Int, String)]()
//
//  if let champsArr = champs as? [String:Any] {
//    print(champsArr)
//    let name = champsArr["name"]
//
//    print(name as! String)
//  }
//  return champInfoArr
//}
//getInfo(champs)

print(names)
