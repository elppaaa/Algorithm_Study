import Foundation

/*:
 #### [H-Index](https://programmers.co.kr/learn/courses/30/lessons/42747)
 H-Index는 과학자의 생산성과 영향력을 나타내는 지표입니다. 어느 과학자의 H-Index를 나타내는 값인 h를 구하려고 합니다. 위키백과1에 따르면, H-Index는 다음과 같이 구합니다.
 어떤 과학자가 발표한 논문 n편 중, h번 이상 인용된 논문이 h편 이상이고 나머지 논문이 h번 이하 인용되었다면 h의 최댓값이 이 과학자의 H-Index입니다.
 어떤 과학자가 발표한 논문의 인용 횟수를 담은 배열 citations가 매개변수로 주어질 때, 이 과학자의 H-Index를 return 하도록 solution 함수를 작성해주세요.

 #### 제한사항
 과학자가 발표한 논문의 수는 1편 이상 1,000편 이하입니다.
 논문별 인용 횟수는 0회 이상 10,000회 이하입니다.
 */

func test(_ q: Int, _ a: Int) {
  print(q)
  if q == a { print("정답") }
  else { print("오답") }
}

/*:
 논문의 개수는 citations.count 이고, 각 논문은 배열 내부 숫자만큼 인용되었다.
 배열을 크기순으로 나열하여 확인했을때,
 enumerated 로 인덱스와 함게 나열하였다.
 나열 해보면
  6 5 3 1 0
 0 1 2 3 4
 6개 이상 1개 5개 이상 2개 3개 이상 3개 확인할 수 있다.
 
 i 가 v보다 커지는 시점에서, i 회 이상인용된 논문이 i개인것이다.
 
 [20,19,18,17, 1] 일때에도, 4회 이상인 것이 4건이므로 4다.
 가능한 많은 횟수라고 해도 논문의 건수 이상일 필요는 없다. __이상__ 이므로
*/

func solution(_ citations:[Int]) -> Int {
  for (i, v) in citations.sorted(by: >).enumerated() {
    if i >= v {
      return i
    }
  }
  
  return citations.count
}


test(solution([3,0,6,1,5]), 3)
test(solution([0,1,9]), 1)
test(solution([0,1,1,9]), 1)
test(solution([0,0,0]), 0)
test(solution([12, 11, 10, 9, 8, 1]), 5)
test(solution([6, 6, 6, 6, 6, 1]) ,5)
test(solution([4, 4, 4]) ,3)
test(solution([4, 4, 4, 5, 0, 1, 2, 3]) ,4)
test(solution([10, 11, 12, 13]) ,4)
test(solution([3, 0, 6, 1, 5]) ,3)
test(solution([0, 0, 1, 1]) ,1)
test(solution([0, 1]) ,1)
test(solution([10, 9, 4, 1, 1]), 3)
