import Foundation

/*:
 ### [핸드폰 번호 가리기](https://programmers.co.kr/learn/courses/30/lessons/12948)
 
 프로그래머스 모바일은 개인정보 보호를 위해 고지서를 보낼 때 고객들의 전화번호의 일부를 가립니다.
 전화번호가 문자열 phone_number로 주어졌을 때, 전화번호의 뒷 4자리를 제외한 나머지 숫자를 전부 *으로 가린 문자열을 리턴하는 함수, solution을 완성해주세요.
 
 #### 제한 조건
 s는 길이 4 이상, 20이하인 문자열입니다.
 */

func test(_ q: String, _ a: String) {
  let answer = solution(q)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
인덱스를 이용해 뒤에서 부터 4개의 문자를 획득.
 번호 길이 - 4 만큼 "*" 문자열을 만들고 뒤에 뒤 4개의 문자를 붙인다.
 */


func solution(_ phone_number:String) -> String {
  let index = phone_number.index(phone_number.endIndex, offsetBy: -4)
  let s = phone_number[index...]
  
  return String(repeating: "*", count: phone_number.count - 4) + String(s)
}

test("01033334444", "*******4444")
test("027778888", "*****8888")
