import Foundation

/*:
 ### [모의고사](https://programmers.co.kr/learn/courses/30/lessons/42840?language=swift)
 
 수포자는 수학을 포기한 사람의 준말입니다. 수포자 삼인방은 모의고사에 수학 문제를 전부 찍으려 합니다. 수포자는 1번 문제부터 마지막 문제까지 다음과 같이 찍습니다.
 1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...
 2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...
 3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, ...
 1번 문제부터 마지막 문제까지의 정답이 순서대로 들은 배열 answers가 주어졌을 때, 가장 많은 문제를 맞힌 사람이 누구인지 배열에 담아 return 하도록 solution 함수를 작성해주세요.
 제한 조건
 시험은 최대 10,000 문제로 구성되어있습니다.
 문제의 정답은 1, 2, 3, 4, 5중 하나입니다.
 가장 높은 점수를 받은 사람이 여럿일 경우, return하는 값을 오름차순 정렬해주세요.
 */

func test(_ q: [Int], _ a: [Int]) {
  let answer = solution(q)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 나머지 연산자를 이용해서 순서대로 문제를 찍을 수 있도록 하고, 정답이 일치한다면 `ture`를 반환하여 정답인 문제의 개수를 집계한다.
 reduce 연산자를 이용해 가장 큰 값을 얻어낸다.
 `answer` 배열에 max 값인 애들을 추가해준다.
 */



func solution(_ answers:[Int]) -> [Int] {
  var answer = [Int]()
  let answer1 = [1,2,3,4,5]
  let answer2 = [2,1,2,3,2,4,2,5]
  let answer3 = [3,3,1,1,2,2,4,4,5,5]
  var answerList = Array(repeating: 0, count: 3)
  
  answerList[0] = answers.enumerated().filter { $1 == answer1[$0 % answer1.count] }.count
  answerList[1] = answers.enumerated().filter { $1 == answer2[$0 % answer1.count] }.count
  answerList[2] = answers.enumerated().filter { $1 == answer3[$0 % answer1.count] }.count
  
  let maxValue = answerList.reduce(0) { max($0, $1) }
  answerList.enumerated().map { if $1 == maxValue { answer.append($0+1) } }
  
  return answer
}

test([1,2,3,4,5], [1])
test([1, 3, 2, 4, 2], [1,2,3])
