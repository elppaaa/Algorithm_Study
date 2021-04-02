import Foundation

/*:
 #### [타겟넘버](https://programmers.co.kr/learn/courses/30/lessons/43165?language=swift)
 
 n개의 음이 아닌 정수가 있습니다. 이 수를 적절히 더하거나 빼서 타겟 넘버를 만들려고 합니다. 예를 들어 [1, 1, 1, 1, 1]로 숫자 3을 만들려면 다음 다섯 방법을 쓸 수 있습니다.
 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 사용할 수 있는 숫자가 담긴 배열 numbers, 타겟 넘버 target이 매개변수로 주어질 때 숫자를 적절히 더하고 빼서 타겟 넘버를 만드는 방법의 수를 return 하도록 solution 함수를 작성해주세요.
 
 #### 제한사항
 주어지는 숫자의 개수는 2개 이상 20개 이하입니다.
 각 숫자는 1 이상 50 이하인 자연수입니다.
 타겟 넘버는 1 이상 1000 이하인 자연수입니다.
 */

func test(_ q: Int, _ a: Int) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

/*:
 문제 분류도 DFS/BFS 이고, DFS, BFS 를 연습하고 싶어서 풀게 되었다.
 숫자들로 이루어진 배열 numbers 에서, 각 숫자들을 덧셈과 뺄셈을 적절히 섞어 target이 나오는 조합의 개수를 반환하면 된다.
 모든 경우를 해보아야 함으로 이것을 DFS / BFS 로 순회하여 확인한다.
 
 stack을 이용해 문제를 해결하였다.
 */

func solution(_ numbers:[Int], _ target:Int) -> Int {
  var stack = [(value: Int, level: Int)]()
  var answer = 0
  
  stack.append((value: numbers[0], level: 0))
  stack.append((value: -1*numbers[0], level: 0))

  while !stack.isEmpty {
    var (value, level) = stack.popLast()!
    level += 1
    
    if level < numbers.count {
      let newValue = numbers[level]
      stack.append((value: value+newValue, level: level))
      stack.append((value: value-newValue, level: level))
    } else {
      if value == target {
        answer += 1
      }
    }
  }
  
  return answer
}

solution([1,1,1,1,1], 3)
