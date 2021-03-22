import Foundation

/*:
 ### [기능개발](https://programmers.co.kr/learn/courses/30/lessons/42586)
 
 프로그래머스 팀에서는 기능 개선 작업을 수행 중입니다. 각 기능은 진도가 100%일 때 서비스에 반영할 수 있습니다.
 또, 각 기능의 개발속도는 모두 다르기 때문에 뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고, 이때 뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.
 먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와 각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.
 
 ### 제한 사항
 작업의 개수(progresses, speeds배열의 길이)는 100개 이하입니다.
 작업 진도는 100 미만의 자연수입니다.
 작업 속도는 100 이하의 자연수입니다.
 배포는 하루에 한 번만 할 수 있으며, 하루의 끝에 이루어진다고 가정합니다. 예를 들어 진도율이 95%인 작업의 개발 속도가 하루에 4%라면 배포는 2일 뒤에 이루어집니다.
 */

func test(_ q: ([Int], [Int]), _ a: [Int]) {
  let answer = solution(q.0, q.1)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 먼저 걸리는 날짜를 zip 과 map 이용해서 올림 계산한다.
 
 날짜 배열을 순회하면서 값이 더 크면 배열에 요소를 추가하고, 아니면 마지막 요소의 값에 1을 추가한다.
 */

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
  let days = zip(progresses, speeds).map { Int(ceil( Double(100 - $0) / Double($1) )) }
  
  var header: Int = 0
  var arr = [Int]()
  
  for i in 0..<days.count {
    if days[i] > header {
      header = days[i]
      arr.append(1)
    } else {
      arr[arr.count - 1] += 1
    }
  }
  
  return arr
}


test(([93, 30, 55], [1, 30, 5]), [2, 1])
test(([95, 90, 99, 99, 80, 99], [1, 1, 1, 1, 1, 1]), [1, 3, 2])
