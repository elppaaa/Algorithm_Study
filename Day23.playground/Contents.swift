import Foundation

/*:
 #### [위장](https://programmers.co.kr/learn/courses/30/lessons/42578)
 
 스파이들은 매일 다른 옷을 조합하여 입어 자신을 위장합니다.
 예를 들어 스파이가 가진 옷이 아래와 같고 오늘 스파이가 동그란 안경, 긴 코트, 파란색 티셔츠를 입었다면 다음날은 청바지를 추가로 입거나 동그란 안경 대신 검정 선글라스를 착용하거나 해야 합니다.
 종류  이름
 얼굴  동그란 안경, 검정 선글라스
 상의  파란색 티셔츠
 하의  청바지
 겉옷  긴 코트
 스파이가 가진 의상들이 담긴 2차원 배열 clothes가 주어질 때 서로 다른 옷의 조합의 수를 return 하도록 solution 함수를 작성해주세요.
 
 #### 제한사항
 
 clothes의 각 행은 [의상의 이름, 의상의 종류]로 이루어져 있습니다.
 스파이가 가진 의상의 수는 1개 이상 30개 이하입니다.
 같은 이름을 가진 의상은 존재하지 않습니다.
 clothes의 모든 원소는 문자열로 이루어져 있습니다.
 모든 문자열의 길이는 1 이상 20 이하인 자연수이고 알파벳 소문자 또는 '_' 로만 이루어져 있습니다.
 스파이는 하루에 최소 한 개의 의상은 입습니다.
 */

func test(_ q: Int, _ a: Int) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

/*:
 어릴때 경우의 수를 구하는 문제를 코드로 옮겨놓은 것이다.
 문제의 분류가 해시이기 때문에 딕셔너리를 만들어 해결해 보았다.
 Array[0] 이 이름, Array[1] 이 종류 이기 때문에 이것을 딕셔너리로 만들면, 각 종류별 옷이 몇가지인지 알수 있다.
 각 종류별 옷의 개수 + 1(해당 종류를 입지 않을 경우) 을 모두 곱한 것에 - 1 (아무것도 입지 않을 경우) 계산하여 구한다.
 
 처음에는 dictioanry value에 옷들을 문자열 배열로 포함하였으나, 같은 이름의 의상은 존재하지않으므로 개수만 포함하여도 문제 없어 변경해보았다.
 */

func solution(_ clothes:[[String]]) -> Int {
  var hashes: [String: [String]] = [:]
  var count = 1
  
  clothes.forEach { e in
    let key = e[1]
    let value = e[0]
    
    if hashes[key] == nil {
      hashes[key] = [value]
    } else {
      hashes[key]?.append(value)
    }
  }
  
  hashes.keys.forEach { key in
    count *= hashes[key]!.count + 1
  }
  
  
  return count - 1
}


test(solution2([["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]]), 5)
test(solution2([["crowmask", "face"], ["bluesunglasses", "face"], ["smoky_makeup", "face"]]), 3)



func solution2(_ clothes:[[String]]) -> Int {
  var hashes: [String: Int] = [:]
  var count = 1
  
  clothes.forEach { e in
    let key = e[1]
    
    if hashes[key] == nil {
      hashes[key] = 1
    } else {
      hashes[key]? += 1
    }
  }
  
  hashes.keys.forEach { key in
    count *= hashes[key]! + 1
  }
  
  
  return count - 1
}
