import Foundation

/*:
 ### [소수 만들기](https://programmers.co.kr/learn/courses/30/lessons/12977)
 
 주어진 숫자 중 3개의 수를 더했을 때 소수가 되는 경우의 개수를 구하려고 합니다.
 숫자들이 들어있는 배열 nums가 매개변수로 주어질 때, nums에 있는 숫자들 중 서로 다른 3개를 골라 더했을 때 소수가 되는 경우의 개수를 return 하도록 solution 함수를 완성해주세요.
 
 제한사항
 nums에 들어있는 숫자의 개수는 3개 이상 50개 이하입니다.
 nums의 각 원소는 1 이상 1,000 이하의 자연수이며, 중복된 숫자가 들어있지 않습니다.
 */

func test(_ q: [Int], _ a: Int) {
  let answer = solution(q)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 소수를 판별하는 isPrime 함수를 작성하였다.
 세개의 숫자를 가져와야 함으로 중복되는 선택은 피해야 한다.
 `enumerated`를 이용해 인덱스를 확인하고, 인덱스가 중복되지 않도록 map으로 순회한다.
 세개의 합이 소수인지 확인하여 answer를 1씩 더한다.
 */



func solution(_ nums:[Int]) -> Int {
  func isPrime(_ num: Int) -> Bool {
    for i in 2...Int(sqrt(Double(num))) {
      if num % i == 0 {
        return false
      }
    }
    return true
  }
  
  var answer = 0

  nums.enumerated().map { index1, num1 in
    nums.enumerated().map { index2, num2 in
      // 인덱스 중복 회피, index1, index2, index3 순서일때만 사용되도록 함.
      if index1 >= index2 { return }
      nums.enumerated().map { index3, num3 in
        // 인덱스 중복 회피, index1, index2, index3 순서일때만 사용되도록 함.
        if index2 >= index3 { return }
        if isPrime(num1 + num2 + num3) { answer += 1}
      }
    }
  }

  return answer
}

test([1,2,3,4], 1)
test([1,2,7,6,4], 4)
