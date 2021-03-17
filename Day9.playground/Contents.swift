import Foundation

/*:
 ### [최대공약수와 최소공배수](https://programmers.co.kr/learn/courses/30/lessons/12940)
 
 두 수를 입력받아 두 수의 최대공약수와 최소공배수를 반환하는 함수, solution을 완성해 보세요.
 
 배열의 맨 앞에 최대공약수, 그다음 최소공배수를 넣어 반환하면 됩니다.
 예를 들어 두 수 3, 12의 최대공약수는 3, 최소공배수는 12이므로 solution(3, 12)는 [3, 12]를 반환해야 합니다.
 
 #### 제한 사항
 두 수는 1이상 1000000이하의 자연수입니다.
 */

func test(_ q: (Int, Int), _ a: [Int]) {
  let answer = solution(q.0, q.1)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 유클리드 호재법을 재귀함수를 이용해 구현하였다.
 큰수에서 작은수를 서로 나머지로 나누어 최대공약수를 얻는 방법이다.
 최소공배수는 두수의 곱을 최대 공약수로 나눈 수이다.
 */

 
func solution(_ n:Int, _ m:Int) -> [Int] {
  func getGCD(_ n: Int, _ m: Int) -> Int {
    m == 0 ? n : getGCD(m, n%m)
  }
  
  let gcd = n > m ? getGCD(n, m) : getGCD(m, n)
  let lcm = n * m / gcd
  
  return [gcd, lcm]
}


test((3, 12), [3, 12])
test((2, 5), [1, 10])
