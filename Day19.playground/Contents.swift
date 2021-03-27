import Foundation

/*:
 #### [가장 큰 수](https://programmers.co.kr/learn/courses/30/lessons/42746)
 수들 중에서 가장 큰 수를 구하는 문제이다.
 0 또는 양의 정수가 주어졌을 때, 정수를 이어 붙여 만들 수 있는 가장 큰 수를 알아내 주세요.
 예를 들어, 주어진 정수가 [6, 10, 2]라면 [6102, 6210, 1062, 1026, 2610, 2106]를 만들 수 있고, 이중 가장 큰 수는 6210입니다.
 0 또는 양의 정수가 담긴 배열 numbers가 매개변수로 주어질 때, 순서를 재배치하여 만들 수 있는 가장 큰 수를 문자열로 바꾸어 return 하도록 solution 함수를 작성해주세요.
 
 ##### 제한 사항
 numbers의 길이는 1 이상 100,000 이하입니다.
 numbers의 원소는 0 이상 1,000 이하입니다.
 정답이 너무 클 수 있으니 문자열로 바꾸어 return 합니다.
 */

/*:
처음에는 직접 정렬 알고리즘을 구현해보려 하였다.
재귀형식으로 다음글자를 비교해가면서 구현하려고 하였다.
예를 들어 "34", "35" 일때, 첫번째 자리 3이 동일함으로 "4", "5" 를 비교하는 식으로 하여
"30", "34", "3" 일때, "34", "3", "30" 으로 정렬되도록 하려 하였다.
그렇게 구현한 것이 numberSort 이다. 하지만 한글자씩 탐욕법? 으로 구현해보니문제가 있다.
40, 403 일때,  순서상에는 403이 앞이나 40340 보다 40403이 더 크다.
*/

func numberSort(_ el1: String, _ el2: String) -> Bool {
  if el1 == el2 { return true }
  
  let _el1 = el1.map { String($0) }
  let _el2 = el2.map { String($0) }
    
  if _el1[0] == _el2[0] {
    let e1 = _el1.indices ~= 1 ? _el1[1...].joined() : el1
    let e2 = _el2.indices ~= 1 ? _el2[1...].joined() : el2
    return numberSort(e1, e2)
  }
  
  return el1 > el2
}

func solution2(_ numbers:[Int]) -> String {
  let sorted = Int64(numbers.map { String($0) }.sorted(by: numberSort).joined())!
  return sorted == 0 ? "0" : String(sorted)
}

/*:
 따라서 직접 수를 만들어 비교하는 방식이 더 작성하기 간단하고 효율적이였다.
 두가지로 만들어 본 후 더 큰 경우로 반환한다. 해당 방식으로 정렬을 수행하였을 때 정상적으로 정렬이 수행되었다.
 
 다만, 배열에 요소가 모두 0인경우, "0000" 과 같이 표현된다.
 이때에는 0으로 만들어 반환해준다.
 String(Int()) 으로 두번 형 변환을 시도해 보았으나, 문제 제출에서 런타임 에러가 발생하여 변경하였다.
  */

func solution(_ numbers: [Int]) -> String {
  let sorted = numbers.map { String($0) }
    .sorted { Int64($0+$1)! > Int64($1+$0)! }
    .joined()
  return sorted[sorted.startIndex] == "0" ? "0" : sorted
}

func test(_ q: String, _ a: String) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

test(solution([6, 10, 2]), "6210")
test(solution([3, 30, 34, 5, 9]), "9534330")

test(solution([0, 5, 10, 15, 20]), "52015100")
test(solution([1000, 0, 5, 99, 100]), "99510010000")
test(solution([0, 0, 0, 0, 0]), "0")
test(solution([40, 403]), "40403")
