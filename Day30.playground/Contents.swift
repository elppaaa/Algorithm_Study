import Foundation


/*:
 [소수 찾기](https://programmers.co.kr/learn/courses/30/lessons/42839)

 한자리 숫자가 적힌 종이 조각이 흩어져있습니다. 흩어진 종이 조각을 붙여 소수를 몇 개 만들 수 있는지 알아내려 합니다.
 각 종이 조각에 적힌 숫자가 적힌 문자열 numbers가 주어졌을 때, 종이 조각으로 만들 수 있는 소수가 몇 개인지 return 하도록 solution 함수를 완성해주세요.

 #### 제한사항
 numbers는 길이 1 이상 7 이하인 문자열입니다.
 numbers는 0~9까지 숫자만으로 이루어져 있습니다.
 "013"은 0, 1, 3 숫자가 적힌 종이 조각이 흩어져있다는 의미입니다.

 #### 입출력 예
 numbers  return
 "17"     3
 "011"    2
 */



func test<T: Comparable>(_ q: T, _ a: T) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

/*:
 1. 가능한 모든 수의 조합을 구한다.
 2. 해당 수가 소수인지 판별한다.
 3. 소수의 개수를 센다.

 가능한 모든 수의 조합을 구하는 것이 어려웠다. 조합에 대한 부분은 끙끙대다 알고리즘 코드를 참고 하였다.

 문자열로 이루어진 숫자들을 순서를 고려한 조합을 생성하고,
 Set 로 다루어 중복이 없도록 한다.
 또 해당 수가 소수인지 판별하여, 소수의 개수를 반환한다.
 */

func solution(_ _numbers:String) -> Int {
  let numbers = _numbers.map { String($0) }

  return Set(
    combination(numbers.count, numbers)
      .map { Int($0)! }
      .filter { $0.isPrime }
  )
  .count
}

extension Int {
  var isPrime: Bool {
    if self < 2 { return false }
    for i in 2..<( Int(sqrt(Double(self)))+1 ) {
      if self % i == 0 { return false }
    }
    return true
  }
}

func combination(_ length: Int, _ array: [String]) -> Set<String> {
  if length == 1 { return Set(array) }

  var result = Set<String>()
  for i in 0..<array.count {
    var tempArray = array
    let num = tempArray.remove(at: i)

    let afterComb = combination(length-1, tempArray)
    let afterCombArr = afterComb.compactMap{num + $0}

    result = result.union(afterComb)
    result = result.union(afterCombArr)
  }

  return result
}

test(solution("17"), 3)
test(solution("011"), 2)
