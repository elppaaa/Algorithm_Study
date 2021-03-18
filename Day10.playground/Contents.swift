import Foundation

/*:
 ### [행렬의 덧셈](https://programmers.co.kr/learn/courses/30/lessons/12950)
 
 행렬의 덧셈은 행과 열의 크기가 같은 두 행렬의 같은 행, 같은 열의 값을 서로 더한 결과가 됩니다. 2개의 행렬 arr1과 arr2를 입력받아, 행렬 덧셈의 결과를 반환하는 함수, solution을 완성해주세요.
 
 #### 제한 조건
 행렬 arr1, arr2의 행과 열의 길이는 500을 넘지 않습니다.
 */

func test(_ q: ([[Int]], [[Int]]), _ a: [[Int]]) {
  let answer = solution(q.0, q.1)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 행렬의 덧셈에서는 같은 모양의 행렬이므로, 첫번째 파라미터 행렬의 크기를 구해 인덱스로 순회한다.
 
 좋아요가 많은 답안 중 zip 과 map 을 조합해 두개의 행렬을 더하는 방법도 있었다. (solution2)
 */

 
func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
  var arr = [[Int]]()
  
  for column in 0..<arr1.count {
    var tmp = [Int]()
    for row in 0..<arr1[0].count {
      tmp.append(arr1[column][row] + arr2[column][row])
    }
    arr.append(tmp)
  }
  return arr
}

func solution2(_ arr1: [[Int]], _ arr2: [[Int]]) -> [[Int]] {
  zip(arr1, arr2).map { zip($0, $1).map { $0 + $1 } }
}


test(([[1,2], [2,3]], [[3, 4], [5, 6]]), [[4, 6], [7, 9]])
test( ([[1], [2]], [[3], [4]]), [[4], [6]] )

let arr1 = [[1,2], [2,3]]

arr1[0].count

