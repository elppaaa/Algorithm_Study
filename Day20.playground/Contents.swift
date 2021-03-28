import Foundation
/*:
 
 ### [조이스틱](https://programmers.co.kr/learn/courses/30/lessons/42860)
 
 문제 설명
 
 조이스틱으로 알파벳 이름을 완성하세요. 맨 처음엔 A로만 이루어져 있습니다.
 ex) 완성해야 하는 이름이 세 글자면 AAA, 네 글자면 AAAA
 
 조이스틱을 각 방향으로 움직이면 아래와 같습니다.
 ▲ - 다음 알파벳
 ▼ - 이전 알파벳 (A에서 아래쪽으로 이동하면 Z로)
 ◀ - 커서를 왼쪽으로 이동 (첫 번째 위치에서 왼쪽으로 이동하면 마지막 문자에 커서)
 ▶ - 커서를 오른쪽으로 이동
 
 예를 들어 아래의 방법으로 "JAZ"를 만들 수 있습니다.
 - 첫 번째 위치에서 조이스틱을 위로 9번 조작하여 J를 완성합니다.
 - 조이스틱을 왼쪽으로 1번 조작하여 커서를 마지막 문자 위치로 이동시킵니다.
 - 마지막 위치에서 조이스틱을 아래로 1번 조작하여 Z를 완성합니다.
 따라서 11번 이동시켜 "JAZ"를 만들 수 있고, 이때가 최소 이동입니다.
 
 만들고자 하는 이름 name이 매개변수로 주어질 때, 이름에 대해 조이스틱 조작 횟수의 최솟값을 return 하도록 solution 함수를 만드세요.
 
 ##### 제한 사항
 name은 알파벳 대문자로만 이루어져 있습니다.
 name의 길이는 1 이상 20 이하입니다.
 */

func test(_ s: Int, _ answer: Int) {
  print(s)
  if s == answer { print("정답") }
  else { print("오답") }
}


/*
 한 방향으로만 가는 경우는 문자열 길이 - 1
 갔다가 돌아와야 하는 경우 ( 중간에 A가 있어 중간을 경유하는 것이 손해일 경우.
 
 각 위치의 알파벳을 변경하는 작업의 최소 이동은 정해져 있다. minUpDown(c:) 에 구현한다.
 solution으로 현재 상황에서 오른쪽으로 이동했다가 왼쪽으로 돌아가는 것이 더 비용이 적은지 확인한다.
 
 (0..<name.count) 으로 순회하며 모든 index의 경우에서 확인한다.
 A가 아닐 시에는 다음 값이 어디까지 A 인지 확인하고, 반대쪽으로 갔다가 돌아오는 비용을 계산한다.
 갔다가 돌아옴으로 * 2 에 현재까지 이동한 길이 (name.count - index)
 반대쪽으로 갔다가 돌아오는 것이 순서대로 순회하는 것보다 비용이 적을 경우 해당 방식을 채택한다.
 
 ---
 
 하지만 질문을 보니 더 다양한 조건을 생각해 비용을 계산해야 하지만 문제의 해답에서 그러한 부분이 고려되지 않고 있음을 알 수 있다.
 예로. AZACAAAB 일 경우 뒤를 갔다가 앞을 오면, ⬅️⬆️➡️➡️⬇️➡️⬆️⬆️으로 가능 할 것 같은데,
 
 1번째 에서 왼쪽으로 마지막으로 이동하는 것은 가능하다고 설명되어 있으나,
 마지막에서 오른쪽으로 첫 번째로 이동하는 것이 가능하다고 설명되어 있지는 않다.
 
 불가능 하다고 하면 ➡️⬇️➡️➡️⬆️⬆️⬅️⬅️⬅️⬅️⬆️ 으로 11개가 맞다.
 
 */

func minUpDown(c: Character) -> Int {
  let A = 65
  let up = Int(c.asciiValue!) - A
  let down = abs(26 - (Int(c.asciiValue!) - A))
  
  return min(up, down)
}


func solution(_ name: String) -> Int {
  var count = name.count - 1
  let name = name.map { $0 }
  
  // up / down 개수는 변경되지 않음.
  let upDownCount = name.reduce(0) { $0 + minUpDown(c: $1) }
  
  // 해당 인덱스에서 돌아 가는 것이 더 적은 비용일지 확인한다.
  for i in 0..<name.count {
    if name[i] != "A" {
      var index = i + 1
      
      while name.indices ~= index && name[index] == "A" { index += 1 }
      let move = i * 2 + name.count - index
      count = min(move, count)
    }
  }
  
  return upDownCount + count
}


test(solution("JEROEN"), 56)
test(solution("JAN"), 23)
test(solution("AZACAAAB"), 11) // 8? 
