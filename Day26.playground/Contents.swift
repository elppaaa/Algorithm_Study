import Foundation
/*
 #### [피보나치 수](https://programmers.co.kr/learn/courses/30/lessons/12945)
 
 문제 설명
 
 피보나치 수는 F(0) = 0, F(1) = 1일 때, 1 이상의 n에 대하여 F(n) = F(n-1) + F(n-2) 가 적용되는 수 입니다.
 예를들어
 F(2) = F(0) + F(1) = 0 + 1 = 1
 F(3) = F(1) + F(2) = 1 + 1 = 2
 F(4) = F(2) + F(3) = 1 + 2 = 3
 F(5) = F(3) + F(4) = 2 + 3 = 5
 와 같이 이어집니다.
 2 이상의 n이 입력되었을 때, n번째 피보나치 수를 1234567으로 나눈 나머지를 리턴하는 함수, solution을 완성해 주세요.
 
 ####  제한 사항
 * n은 1이상, 100000이하인 자연수입니다.
 */

func test(_ a: Int, _ b: Int ) {
  print(a)
  if a == b { print("정답") }
  else { print("오답") }
}


/*: 피보나치 수열에서 n 번째 수를 1234567로 나눈 나머지를 출력한다.
 
 가정 처음에는 그냥 단순하게 __solution(_:) 처럼 문제에서 주어진 대로 나머지만 마지막에 구하여 반환했다.
 그 다음에 시간초과가 나는 것을 보고,  캐싱을 이용해야겠다고 생각해서 배열에 값을 넣고 꺼내어 쓰는 방식으로 수행하였다.
 그렇게 풀어도 시간초과가 났다.
 생각해보니 피보나치 수열은 수가 가면갈수록 기하 급수적으로 증가한다. 문제에서는 1234567로 나눈 나머지를 요구함으로
 (A+B)%C = (A%C+B%C)%C 인 특징을 이용해 모듈러 연산된 결과를 배열에 저장하여 문제를 풀었다.
 
 피보나치를 재귀로 풀려고 생각했지만, n 번째 수만 구하는 것이기 때문에 반복문을 이용해서 값을 구하는 것이 가장 효율적이라고 생각한다. _solution(_:)
 실제로 _solution(_:) 함수가 가장 빠른 속도를 보여주었다.
 */

func solution(_ n:Int) -> Int {
  var memoize = [Int](repeating: -1, count: n)
  memoize[0] = 0
  memoize[1] = 1
  
  func F(_ n: Int) -> Int {
    if n == 0 || n == 1 { return memoize[n] }
    
    var f1: Int = memoize[n-1]
    var f2: Int = memoize[n-2]
    
    if memoize[n-2] == -1 {
      f2 = F(n-3) + F(n-4)
      memoize[Int(n)-2] = f2
    }
    
    if memoize[n-1] == -1 {
      f1 = F(n-2) + F(n-3)
      memoize[n-1] = f1
    }
    
    
    return (f1 + f2) % 1234567
  }
  
  return F(n)
}

func _solution(_ n:Int) -> Int {
  var v1: Int = 0
  var v2: Int = 1
  
  for _ in 2...n {
    let v = v1 + v2
    v1 = v2
    v2 = v % 1234567
  }
  
  return v2
}

func __solution(_ n:Int) -> Int {
  func F(_ n: Int) -> Int {
    if n == 0 || n == 1 { return n }
    return F(n-1) + F(n-2)
  }
  
  return F(n) % 1234567
}

test(solution(3), 2)
test(solution(5), 5)
