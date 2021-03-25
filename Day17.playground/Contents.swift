import Foundation

/*:
 ### [삼각 달팽이](https://programmers.co.kr/learn/courses/30/lessons/68645)
 정수 n이 매개변수로 주어집니다. 다음 그림과 같이 밑변의 길이와 높이가 n인 삼각형에서 맨 위 꼭짓점부터 반시계 방향으로 달팽이 채우기를 진행한 후, 첫 행부터 마지막 행까지 모두 순서대로 합친 새로운 배열을 return 하도록 solution 함수를 완성해주세요.
 ![images](examples.png)
 */


func test(_ q: Int, _ a: [Int]) {
  let answer = solution(q)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

typealias PosType = (column: Int, row: Int)

enum Arrow {
  case downLeft
  case right
  case upLeft
  
  func move(_ pos: PosType) -> PosType {
    switch self {
    case .downLeft:
      return (pos.0 + 1, pos.1)
    case .right:
      return (pos.0, pos.1 + 1)
    case .upLeft:
      return (pos.0 - 1, pos.1 - 1)
    }
  }
  
  mutating func changeDirection() {
    switch self {
    case .downLeft:
      self = .right
    case .right:
      self = .upLeft
    case .upLeft:
      self = .downLeft
    }
  }
}

extension Array {
  subscript (safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

/*:
 처음에는 패턴을 찾아 문제를 해결하고자 하였으나, 패턴이 오려운 것 같아서 직접 이동하면서 값을 채워나가는 방법을 사용하였다.
 
 좌표를 나타내는 튜플로 PosType, 방향을 가지는 Arrow 를 두었다.
 
 Arrow 에서는 방향에 따라 좌표 이동하도록 move 함수를 두었고, 방향 전환을 위한 changeDirection 함수를 두었다.
 
 배열은 안전하게 접근할 수 있도록 extension을 이용해 indexs 를 확인하는 절차를 두었다.
 
 좌표를 이동하고, 순차적으로 증가하는 값을 채워 넣었다.
 
 존재하지 않는 좌표이거나, 이미 값이 채워져 있을 때에는 방향 전환을 수행한다.
 */

func solution(_ n:Int) -> [Int] {
  var answer = [[Int]]()
  var arrow = Arrow.downLeft
  var pos: PosType = (-1, 0)
  var i = 1
  let limit = (1...n).reduce(0, +)
  
  // 빈 배열을 먼저 생성.
  (1...n).map { answer.append(Array(repeating: 0, count: $0)) }
  
  while i <= limit {
    // 예상되는 이동 좌표
    let _pos = arrow.move(pos)
    
    // 이미 값이 채워져있거나, 존재하지 않는 위치일 경우 방향 전환.
    if answer[safe: _pos.column]?[safe: _pos.row] == nil
        || answer[_pos.column][_pos.row] != 0 {
      arrow.changeDirection()
    // 정상적인 위치라면 좌표 변경 및 값 대입
    } else {
      pos = _pos
      answer[pos.column][pos.row] = i
      i += 1
    }
  }

  // 2차원 배열 1차원으로 축소
  return answer.reduce([], +)
}

test(4, [1,2,9,3,10,8,4,5,6,7])
test(5, [1,2,12,3,13,11,4,14,15,10,5,6,7,8,9])
test(6, [1,2,15,3,16,14,4,17,21,13,5,18,19,20,12,6,7,8,9,10,11])
