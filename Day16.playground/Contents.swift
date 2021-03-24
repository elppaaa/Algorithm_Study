import Foundation

/*:
 ### [문자열 압축](https://programmers.co.kr/learn/courses/30/lessons/60057?language=swift)
 
 데이터 처리 전문가가 되고 싶은 "어피치"는 문자열을 압축하는 방법에 대해 공부를 하고 있습니다. 최근에 대량의 데이터 처리를 위한 간단한 비손실 압축 방법에 대해 공부를 하고 있는데, 문자열에서 같은 값이 연속해서 나타나는 것을 그 문자의 개수와 반복되는 값으로 표현하여 더 짧은 문자열로 줄여서 표현하는 알고리즘을 공부하고 있습니다.
 간단한 예로 "aabbaccc"의 경우 "2a2ba3c"(문자가 반복되지 않아 한번만 나타난 경우 1은 생략함)와 같이 표현할 수 있는데, 이러한 방식은 반복되는 문자가 적은 경우 압축률이 낮다는 단점이 있습니다. 예를 들면, "abcabcdede"와 같은 문자열은 전혀 압축되지 않습니다. "어피치"는 이러한 단점을 해결하기 위해 문자열을 1개 이상의 단위로 잘라서 압축하여 더 짧은 문자열로 표현할 수 있는지 방법을 찾아보려고 합니다.
 예를 들어, "ababcdcdababcdcd"의 경우 문자를 1개 단위로 자르면 전혀 압축되지 않지만, 2개 단위로 잘라서 압축한다면 "2ab2cd2ab2cd"로 표현할 수 있습니다. 다른 방법으로 8개 단위로 잘라서 압축한다면 "2ababcdcd"로 표현할 수 있으며, 이때가 가장 짧게 압축하여 표현할 수 있는 방법입니다.
 다른 예로, "abcabcdede"와 같은 경우, 문자를 2개 단위로 잘라서 압축하면 "abcabc2de"가 되지만, 3개 단위로 자른다면 "2abcdede"가 되어 3개 단위가 가장 짧은 압축 방법이 됩니다. 이때 3개 단위로 자르고 마지막에 남는 문자열은 그대로 붙여주면 됩니다.
 압축할 문자열 s가 매개변수로 주어질 때, 위에 설명한 방법으로 1개 이상 단위로 문자열을 잘라 압축하여 표현한 문자열 중 가장 짧은 것의 길이를 return 하도록 solution 함수를 완성해주세요.
 
 #### 제한사항
 s의 길이는 1 이상 1,000 이하입니다.
 s는 알파벳 소문자로만 이루어져 있습니다.
 */

func test(_ q: String, _ a: Int) {
  let answer = solution(q)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 문자열을 압축해 최대한 적게 문자열을 사용하는 프로그램이다.
 몇개의 문자로 자르는 것이 가장 효율적인지를 구해야 하는데,
 문자열을 자를 때에는 순서대로 잘라야 하고, 3개의 문자로 자르기로 했으면 순서대로 3개씩 확인을 해야한다.
 처음에는 해당 조건을 빼먹었지만 해당 제약이 문제 난이도를 낮춘 것 같다.
 
 문자열의 총 길이의 반 이상이 넘으면 무조건 압축이 불가능 하므로, 문자열 길이의 반만큼만 순회한다.
 
 먼저 문자열을 길이 단위로 자른다. 이것은 extension으로 구현한다.
 tuple로 문자열과 개수를 가지는 배열로 만들었다.
 자른 문자열들로 이루어진 배열을 순회하면서 이전 문자열과 동일하면 개수를 증가시킨다.
 다른 문자열이면 배열에 추가한다.
 
 이후에 개수를 집계하여 반환한다.
 */

extension String {
  func components(withMaxLength length: Int) -> [String] {
    return stride(from: 0, to: self.count, by: length).map {
      let start = self.index(self.startIndex, offsetBy: $0)
      let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
      return String(self[start..<end])
    }
  }
}



func splitLength(_ s: String, length: Int) -> Int {
  typealias ValueCountType = (value: String, count: Int)
  var componentsArray = [ValueCountType]()
  
  // 문자열을 자른 배열을 순회하면서 배열에 요소를 추가하거나 개수를 증가시킨다.
  s.components(withMaxLength: length).forEach {
    if let last = componentsArray.last?.value,
       last == $0 {
      componentsArray[componentsArray.count-1].count += 1
    } else {
      componentsArray.append((value: $0, count: 1))
    }
  }
  
  // 개수 집계. count 1일 때에는 압축 X
  return componentsArray.reduce(0) { (result, tuple) -> Int in
    let (value, count) = tuple

    if count == 1 {
      return result + value.count
    } else {
      return result + value.count + String(count).count
    }
  }
}

func solution(_ s:String) -> Int {
  if s.count <= 2 { return s.count }
  return  (1..<(s.count/2+1)).reduce(s.count) {
     min($0, splitLength(s, length: $1))
  }
}

test("aabbaccc", 7)
test("ababcdcdababcdcd", 9)
test("abcabcdede", 8)
test("abcabcabcabcdededededede", 14)
test("xababcdcdababcdcd", 17)


test("aaaaaaaaaab", 4)
test("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 4)
test("zxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 5)
test("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxz", 5)
test("xxxxxxxxxxyyy", 5)
test("a", 1)
test("fjeiqjoivauodsfaiowqsdfa", 24)

