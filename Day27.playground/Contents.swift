import Foundation
/*
 #### [올바른 괄호](https://programmers.co.kr/learn/courses/30/lessons/12909)
 
 괄호가 바르게 짝지어졌다는 것은 '(' 문자로 열렸으면 반드시 짝지어서 ')' 문자로 닫혀야 한다는 뜻입니다. 예를 들어
 "()()" 또는 "(())()" 는 올바른 괄호입니다.
 ")()(" 또는 "(()(" 는 올바르지 않은 괄호입니다.
 '(' 또는 ')' 로만 이루어진 문자열 s가 주어졌을 때, 문자열 s가 올바른 괄호이면 true를 return 하고, 올바르지 않은 괄호이면 false를 return 하는 solution 함수를 완성해 주세요.
 
 제한사항
 문자열 s의 길이 : 100,000 이하의 자연수
 문자열 s는 '(' 또는 ')' 로만 이루어져 있습니다.
 */

func test(_ a: Bool, _ b: Bool ) {
  print(a)
  if a == b { print("정답") }
  else { print("오답") }
}

/*
 수를 세는 count 변수를 두어 "(" 일때는 +1 ")" 에는 -1 을 한다.
 음수가 되었을 때에는 )가 더 많아 나왔을 것이므로 개수가 맞지 않아 false 를 리턴한다.
 count 의 개수가 0이 아닐 때에도 짝이 맞지 않은 것이므로 false이다.
 */


func solution(_ s:String) -> Bool {
  var count = 0
  for c in s {
    count += c == "(" ? 1 : -1
    if count < 0 { return false }
  }
  return count == 0 ? true : false
}

test(solution("()()"), true)
test(solution("(())()"), true)
test(solution(")()("), false)
test(solution("(()("), false)
