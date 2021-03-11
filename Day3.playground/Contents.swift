import Foundation

/*:
 ### [신규 아이디 추천](https://programmers.co.kr/learn/courses/30/lessons/72410)
 카카오에 입사한 신입 개발자 네오는 "카카오계정개발팀"에 배치되어, 카카오 서비스에 가입하는 유저들의 아이디를 생성하는 업무를 담당하게 되었습니다. "네오"에게 주어진 첫 업무는 새로 가입하는 유저들이 카카오 아이디 규칙에 맞지 않는 아이디를 입력했을 때, 입력된 아이디와 유사하면서 규칙에 맞는 아이디를 추천해주는 프로그램을 개발하는 것입니다.
 다음은 카카오 아이디의 규칙입니다.
 아이디의 길이는 3자 이상 15자 이하여야 합니다.
 아이디는 알파벳 소문자, 숫자, 빼기(-), 밑줄(_), 마침표(.) 문자만 사용할 수 있습니다.
 단, 마침표(.)는 처음과 끝에 사용할 수 없으며 또한 연속으로 사용할 수 없습니다.
 
 "네오"는 다음과 같이 7단계의 순차적인 처리 과정을 통해 신규 유저가 입력한 아이디가 카카오 아이디 규칙에 맞는 지 검사하고 규칙에 맞지 않은 경우 규칙에 맞는 새로운 아이디를 추천해 주려고 합니다.
 
 신규 유저가 입력한 아이디가 new_id 라고 한다면,
 1단계 new_id의 모든 대문자를 대응되는 소문자로 치환합니다.
 2단계 new_id에서 알파벳 소문자, 숫자, 빼기(-), 밑줄(_), 마침표(.)를 제외한 모든 문자를 제거합니다.
 3단계 new_id에서 마침표(.)가 2번 이상 연속된 부분을 하나의 마침표(.)로 치환합니다.
 4단계 new_id에서 마침표(.)가 처음이나 끝에 위치한다면 제거합니다.
 5단계 new_id가 빈 문자열이라면, new_id에 "a"를 대입합니다.
 6단계 new_id의 길이가 16자 이상이면, new_id의 첫 15개의 문자를 제외한 나머지 문자들을 모두 제거합니다.
 만약 제거 후 마침표(.)가 new_id의 끝에 위치한다면 끝에 위치한 마침표(.) 문자를 제거합니다.
 7단계 new_id의 길이가 2자 이하라면, new_id의 마지막 문자를 new_id의 길이가 3이 될 때까지 반복해서 끝에 붙입니다.
 */

/*:
 문제에서 요구하는 대로 풀이를 진행하면 된다.
 먼저, 소문자로 치환하고, 불필요한 문제를 제거한다.
 문제를 제거할 때에는 filter 를 이용하여 글자 하나하나를 확인하였다.
 그 다음부터는 정규 표현식을 사용하였다. 정규표현식에서 '.' 는 '어떤 문자 하나'를 의미하기 때문에 마침표 그대로를 의미하는 것은 '\\.' 이다.
 '+'는 1글자 이상의 반복을 의미한다. 1글자 이상의 마침표은 모두 마침표 하나로 치환하였다.
 ^, $ 는 각각 문자의 시작과 끝을 의미한다. 이 또한 빈문자와 치환함으로써 제거하였다.
 5단계에서 빈문자일 경우 "a"로 변경한다.
 popLast() 함수를 이용해 글자수가 15글자를 넘을 때 문자를 한글자씩 제거하였다.
 마지막 문자가 마침표일때 치환을 한번 더 해주었다.
 반복문을 이용해서 글자수가 2글자 이하일때 마지막 글자를 더해주도록 하였다.
 */

func test(_ q: String, _ a: String) {
  let _answer = solution(q)
  print(_answer)
  
  if _answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

func solution(_ new_id:String) -> String {
  var string: String = new_id
    // print("case1")
    .lowercased()
    // print("case2")
    .filter {
      $0.isLetter ||
        $0.isNumber ||
        ["-", "_", "."].contains($0)
    }
    // print("case3")
    .replacingOccurrences(of: "\\.+", with: ".", options: .regularExpression)
    // print("case4")
    .replacingOccurrences(of: "^\\.", with: "", options: .regularExpression)
    .replacingOccurrences(of: "\\.$", with: "", options: .regularExpression)

  // print("case5")
  if string == "" { string = "a" }
  

  //print("case6")
  while string.count > 15 { string.popLast() }
  string = string.replacingOccurrences(of: "\\.$", with: "", options: .regularExpression)

  //print("case7")
  while string.count <= 2 {
    string += "\(string.last!)"
  }
  
  return string
}



test("...!@BaT#*..y.abcdefghijklm", "bat.y.abcdefghi")
test("z-+.^.", "z--")
test("=.=",  "aaa")
test("123_.def", "123_.def")
test("abcdefghijklmn.p", "abcdefghijklmn")
