import Foundation

/*:
 ### [예산](https://programmers.co.kr/learn/courses/30/lessons/12982)
 
 S사에서는 각 부서에 필요한 물품을 지원해 주기 위해 부서별로 물품을 구매하는데 필요한 금액을 조사했습니다. 그러나, 전체 예산이 정해져 있기 때문에 모든 부서의 물품을 구매해 줄 수는 없습니다. 그래서 최대한 많은 부서의 물품을 구매해 줄 수 있도록 하려고 합니다.
 물품을 구매해 줄 때는 각 부서가 신청한 금액만큼을 모두 지원해 줘야 합니다. 예를 들어 1,000원을 신청한 부서에는 정확히 1,000원을 지원해야 하며, 1,000원보다 적은 금액을 지원해 줄 수는 없습니다.
 부서별로 신청한 금액이 들어있는 배열 d와 예산 budget이 매개변수로 주어질 때, 최대 몇 개의 부서에 물품을 지원할 수 있는지 return 하도록 solution 함수를 완성해주세요.
 
 #### 제한사항
 d는 부서별로 신청한 금액이 들어있는 배열이며, 길이(전체 부서의 개수)는 1 이상 100 이하입니다.
 d의 각 원소는 부서별로 신청한 금액을 나타내며, 부서별 신청 금액은 1 이상 100,000 이하의 자연수입니다.
 budget은 예산을 나타내며, 1 이상 10,000,000 이하의 자연수입니다.
 */
let q1 = {
  func test(_ q: ([Int], Int), _ a: Int) {
    let answer = solution(q.0, q.1)
    print(answer)
    if answer == a {
      print("정답.")
    } else {
      print("오답.")
    }
  }
  
  /*:
   돈을 최대한 딱 맞게 사용하는 것이 아니라, 최대한 많은 부서에 지원해주는 것이므로
   오름차순으로 예산이 적게 필요한 부서부터 지원해준다고 생각하면 가능한 많은 개수를 얻을 수 있다.
   
   filter를 이용해 부서 예산만큼 budget에서 빼면서 0이상일때까지의 개수를 세는 방법도 있다.
   */
  func solution(_ d:[Int], _ budget:Int) -> Int {
    var n = 0
    for (i, v) in d.sorted().enumerated() {
      n += v
      if n > budget {
        return i
      }
    }
    return d.count
  }
  
  func solution2(_ d: [Int], _ budget: Int) -> Int {
    var budget = budget
    return d.sorted().filter {
      budget = budget - $0
      return budget >= 0
    }.count
  }
  
  test(([1,3,2,5,4], 9), 3)
  test(([2,2,3,3], 10), 4)
}

q1()

/*:
 ### [예산](https://programmers.co.kr/learn/courses/30/lessons/12982)
 
 S사에서는 각 부서에 필요한 물품을 지원해 주기 위해 부서별로 물품을 구매하는데 필요한 금액을 조사했습니다. 그러나, 전체 예산이 정해져 있기 때문에 모든 부서의 물품을 구매해 줄 수는 없습니다. 그래서 최대한 많은 부서의 물품을 구매해 줄 수 있도록 하려고 합니다.
 물품을 구매해 줄 때는 각 부서가 신청한 금액만큼을 모두 지원해 줘야 합니다. 예를 들어 1,000원을 신청한 부서에는 정확히 1,000원을 지원해야 하며, 1,000원보다 적은 금액을 지원해 줄 수는 없습니다.
 부서별로 신청한 금액이 들어있는 배열 d와 예산 budget이 매개변수로 주어질 때, 최대 몇 개의 부서에 물품을 지원할 수 있는지 return 하도록 solution 함수를 완성해주세요.
 
 #### 제한사항
 d는 부서별로 신청한 금액이 들어있는 배열이며, 길이(전체 부서의 개수)는 1 이상 100 이하입니다.
 d의 각 원소는 부서별로 신청한 금액을 나타내며, 부서별 신청 금액은 1 이상 100,000 이하의 자연수입니다.
 budget은 예산을 나타내며, 1 이상 10,000,000 이하의 자연수입니다.
 */


let q2 = {
  func test(_ q: (Int, Int), _ a: [Int64]) {
    let answer = solution(q.0, q.1)
    print(answer)
    if answer == a {
      print("정답.")
    } else {
      print("오답.")
    }
  }
  /*:
   map 을 이용해 Int64 타입의 수로 곱하여 반환한다.
   */
  
  func solution(_ x:Int, _ n:Int) -> [Int64] {
    (1...n).map { Int64(x * $0) }
  }
   
}

