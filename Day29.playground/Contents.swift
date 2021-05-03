import Foundation

/*
 #### [최대값과 최솟값](https://programmers.co.kr/learn/courses/30/lessons/12939) 
 문자열 s에는 공백으로 구분된 숫자들이 저장되어 있습니다. str에 나타나는 숫자 중 최소값과 최대값을 찾아 이를 "(최소값) (최대값)"형태의 문자열을 반환하는 함수, solution을 완성하세요.
 예를들어 s가 "1 2 3 4"라면 "1 4"를 리턴하고, "-1 -2 -3 -4"라면 "-4 -1"을 리턴하면 됩니다.

 #### 제한 조건
 s에는 둘 이상의 정수가 공백으로 구분되어 있습니다.
 */
func test<T: Comparable>(_ q: T, _ a: T) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}


/*:
가장 먼저 문자열을 공백 단위로 구분하고, 나누어진 문자를 정수형으로 형변환한다.
이후 정렬하여 첫번째와 마지막 요소를 반환한다.
 */
func solution(_ s:String) -> String {
  let list = s.split(separator: " ").map { Int($0)! }.sorted()
  return "\(list.first!) \(list.last!)"
}

test(solution("1 2 3 4"), "1 4")
test(solution("-1 -2 -3 -4"), "-4 -1")
test(solution("-1 -1"), "-1 -1")
