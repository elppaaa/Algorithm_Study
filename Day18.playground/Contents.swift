import Foundation

/*:
 #### [큰 수 만들기](https://programmers.co.kr/learn/courses/30/lessons/42883)
 어떤 숫자에서 k개의 수를 제거했을 때 얻을 수 있는 가장 큰 숫자를 구하려 합니다.
 예를 들어, 숫자 1924에서 수 두 개를 제거하면 [19, 12, 14, 92, 94, 24] 를 만들 수 있습니다. 이 중 가장 큰 숫자는 94 입니다.
 문자열 형식으로 숫자 number와 제거할 수의 개수 k가 solution 함수의 매개변수로 주어집니다. number에서 k 개의 수를 제거했을 때 만들 수 있는 수 중 가장 큰 숫자를 문자열 형태로 return 하도록 solution 함수를 완성하세요.
 
 ##### 제한 조건
 number는 1자리 이상, 1,000,000자리 이하인 숫자입니다.
 k는 1 이상 number의 자릿수 미만인 자연수입니다.
 */

/*:
 먼저 어떠한 패턴으로 문자를 제거해야 하는지 확인해본다.
 문제의 분류가 탐욕법이기에, 앞에서부터 제거해야할 조건을 확인해본다.
 
 가장 이상적인 경우가 내림차순이므로,  앞에 숫자가 다음에 나와야 할 숫자보다 작다면 제거한다. 제거해야할 개수(k) 또한 그에 맞추어 감소한다.
 
 가령 예제 처럼 ("1924", 2)라면, 1,9 에서 1 제거 9, 2 통과, 2, 4에서 4 제거가 이루어진다.
 
 비교를 수행하게 되면 ("4177", 2) 일때, 4-1 통과 1-7 1제거, 하여 477이 되는데, 이때 4가 제거되는 것이 가장 바람직하다.
 정답을 담을 배열을 두고, 배열의 마지막 값과 다음 차례의 숫자를 비교하여 제거하고, 다시 비교를 수행한다면, 갖은 숫자가 점점 사라져 큰 수의 내림차순으로 가까워 질 것이다.
 
 하지만 이러한 패턴으로 제거를 수행해도 제거해야 하는 개수 k에 만큼 제거되지 않을 수 있다.
 내림차순에 가깝게 구성되어 있음으로 뒤에 숫자가 작을 것이다. 마지막 숫자를 k만큼 제거한다.
 */

func solution(_ number:String, _ k:Int) -> String {
  let _array = number.map { Int(String($0))! }
  var count = k
  let length = number.count - k
  var answer = [Int]()
  
  for e in _array {
    // e보다 answer.last 가 작다면 하나씩 pop 이외에는 answer에 추가함.
    while true {
      if answer.count == 0 || count == 0 { answer.append(e); break }
      if answer.last! < e && count > 0 { answer.removeLast(); count -= 1; continue }
      answer.append(e)
      break
    }
  }
  
  // 제거할 개수에 맞추어 제거함.
  while answer.count != length { answer.popLast() }
  
  return answer.reduce("", { "\($0)\($1)" })
}

func test(_ q: String, _ a: String) {
  print(q)
  if q == a {
    print("정답")
  } else {
    print("오답")
  }
}

test(solution("1924", 2), "94")
test(solution("1231234", 3), "3234")
test(solution("4177252841", 4), "775841")
test(solution("54321", 2), "543")
