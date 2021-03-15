import Foundation

/*:
 ### [K번째 수](https://programmers.co.kr/learn/courses/30/lessons/42748)
 
 배열 array의 i번째 숫자부터 j번째 숫자까지 자르고 정렬했을 때, k번째에 있는 수를 구하려 합니다.
 예를 들어 array가 [1, 5, 2, 6, 3, 7, 4], i = 2, j = 5, k = 3이라면
 array의 2번째부터 5번째까지 자르면 [5, 2, 6, 3]입니다.
 1에서 나온 배열을 정렬하면 [2, 3, 5, 6]입니다.
 2에서 나온 배열의 3번째 숫자는 5입니다.
 배열 array, [i, j, k]를 원소로 가진 2차원 배열 commands가 매개변수로 주어질 때, commands의 모든 원소에 대해 앞서 설명한 연산을 적용했을 때 나온 결과를 배열에 담아 return 하도록 solution 함수를 작성해주세요.
 제한사항
 array의 길이는 1 이상 100 이하입니다.
 array의 각 원소는 1 이상 100 이하입니다.
 commands의 길이는 1 이상 50 이하입니다.
 commands의 각 원소는 길이가 3입니다.
 */

func test(_ q: ([Int], [[Int]]), _ a: [Int]) {
  let answer = solution(q.0, q.1)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 배열이 여러개 존재하므로 2차원 배열인 commands를 순회한다.
 commands 내부 배열을 arr 이라 하면, `(arr[0]-1)` 에서부터 `(arr[1]-1)` 까지의 인덱스를 사용한다. (arr[1]-1 대신 <arr[1] 으로 접근하였다.)
 subsript 로 접근하게되면 ArraySlice 가 생성됨으로 ArraySlice 를 Array 로 변환한다.
 해당 Array를 정렬하고 n 번째인 `arr[2]-1`으로 접근한다.
 이것을 map으로 순회하면 해당 값들만 반환된 배열이 생성된다.
 */


func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
  return commands.map {
    Array(array[($0[0]-1)..<$0[1]]).sorted()[$0[2]-1]
  }
}

test(([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]]), [5, 6, 3])


