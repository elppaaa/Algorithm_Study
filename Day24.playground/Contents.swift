import Foundation
/*:
 [메뉴 리뉴얼](https://programmers.co.kr/learn/courses/30/lessons/72411)
 레스토랑을 운영하던 스카피는 코로나19로 인한 불경기를 극복하고자 메뉴를 새로 구성하려고 고민하고 있습니다.
 기존에는 단품으로만 제공하던 메뉴를 조합해서 코스요리 형태로 재구성해서 새로운 메뉴를 제공하기로 결정했습니다. 어떤 단품메뉴들을 조합해서 코스요리 메뉴로 구성하면 좋을 지 고민하던 "스카피"는 이전에 각 손님들이 주문할 때 가장 많이 함께 주문한 단품메뉴들을 코스요리 메뉴로 구성하기로 했습니다.
 단, 코스요리 메뉴는 최소 2가지 이상의 단품메뉴로 구성하려고 합니다. 또한, 최소 2명 이상의 손님으로부터 주문된 단품메뉴 조합에 대해서만 코스요리 메뉴 후보에 포함하기로 했습니다.
 예를 들어, 손님 6명이 주문한 단품메뉴들의 조합이 다음과 같다면,
 (각 손님은 단품메뉴를 2개 이상 주문해야 하며, 각 단품메뉴는 A ~ Z의 알파벳 대문자로 표기합니다.)
 
 손님 번호  주문한 단품메뉴 조합
 1번 손님  A, B, C, F, G
 2번 손님  A, C
 3번 손님  C, D, E
 4번 손님  A, C, D, E
 5번 손님  B, C, F, G
 6번 손님  A, C, D, E, H
 
 가장 많이 함께 주문된 단품메뉴 조합에 따라 "스카피"가 만들게 될 코스요리 메뉴 구성 후보는 다음과 같습니다.
 코스 종류  메뉴 구성  설명
 요리 2개 코스  A, C  1번, 2번, 4번, 6번 손님으로부터 총 4번 주문됐습니다.
 요리 3개 코스  C, D, E  3번, 4번, 6번 손님으로부터 총 3번 주문됐습니다.
 요리 4개 코스  B, C, F, G  1번, 5번 손님으로부터 총 2번 주문됐습니다.
 요리 4개 코스  A, C, D, E  4번, 6번 손님으로부터 총 2번 주문됐습니다.
 
 각 손님들이 주문한 단품메뉴들이 문자열 형식으로 담긴 배열 orders, "스카피"가 추가하고 싶어하는 코스요리를 구성하는 단품메뉴들의 갯수가 담긴 배열 course가 매개변수로 주어질 때, "스카피"가 새로 추가하게 될 코스요리의 메뉴 구성을 문자열 형태로 배열에 담아 return 하도록 solution 함수를 완성해 주세요.
 */

func test(_ q: [String], _ a: [String]) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

/*:
 가장 먼저는 2개 3개 4개 짜리 요소가 다른 요소에도 포함되는지 확인하는 방식으로 해보았으나, 모든 케이스에서 해당되는 조건이 아니였다.
 그 다음은 출현하는 모든 문자열에 해당하는 조합을 모두 생성한 후 주어진 orders에 포함되는 문자열을 집계하여 계산하였음. 하지만 시간초과로 변경함.
 
 다음은 orders 요소들로 생성할 수 있는 조합들로 계산하였다. 먼저 orders의 각 요소들로 모든 조합을 생성한다. 조합은 dfs 를 이용하여 조합을 생성하였다.
 
 그리고 생성된 조합이 orders에 몇개나 속하는지 개수를 count 하였고, 그 중 가장 많은 것을 출력하였다.
 모든 알파벳을 가져와 모든 조합을 생성하게 되면 한번도 카운팅될 수 없는 (존재할 수 없는) 조합도 생성될 수 있기 때문에 낭비가 생긴다.
 */


func combination<T>(_ array: [T], n: Int) -> [[T]] {
  var stack = [(value: [T], index: Int)]()
  var result = [[T]]()
  
  stack.append( ([array[0]], 0) )
  stack.append( ([], 0) )
  
  while !stack.isEmpty {
    var (value, index) = stack.popLast()!
    index += 1
    
    if value.count == n { result.append(value); continue }
    if index == array.count { continue }
    
    stack.append( (value + [array[index]], index) )
    stack.append( (value, index) )
  }

  return result
}


func solution(_ orders: [String], _ course: [Int]) -> [String] {
  var answer = [String]()
  
  course.forEach { n in
    var counter = [String:Int]()
    
    orders.reduce([""]) { $0 + combination($1.sorted().map { String($0) }, n: n)
      .map { $0.joined() }}
      .map {
      if counter[$0] == nil {
        counter[$0] = 1
      } else {
        counter[$0]! += 1
      }
    }
    
    counter = counter.filter { $0.value > 1}
    
    let maxValue = counter.reduce(-1) { max($0, $1.value) }
    
    counter.filter { $0.value == maxValue }.map { answer.append($0.key) }
  }
  
  
  return answer.sorted()
}



test(
  solution(["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"],[2,3,4]),
  ["AC", "ACDE", "BCFG", "CDE"]
)


test(
  solution(["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"], [2,3,5]),
  ["ACD", "AD", "ADE", "CD", "XYZ"]
)

test(
  solution(["XYZ", "XWY", "WXA"], [2,3,4]),
  ["WX", "XY"]
)



func __solution(_ _orders:[String], _ course:[Int]) -> [String] {
  let characters = Array(Set(_orders.reduce("") { $0 + $1 } )).sorted()
  var answer = [String]()
  
  course.forEach { n in
    let combinations = combination(characters, n: n)
    var counter = [String: Int]()
    
    combinations.map { chars in
      let count = _orders.filter { order in
        chars.allSatisfy { order.contains($0) }
      }.count
      
      if count > 1 {
        counter[String(chars)] = count
      }
    }
    
    let maxValue = counter.reduce(-1) { max($0, $1.value) }
    
    for key in counter.keys {
      if counter[key] == maxValue {
        answer.append(key)
      }
    }
    
  }
  
  return answer.sorted()
}
