import Foundation

/*
 #### [가장 큰 정사각형 찾기](https://programmers.co.kr/learn/courses/30/lessons/12905)

 1와 0로 채워진 표(board)가 있습니다. 표 1칸은 1 x 1 의 정사각형으로 이루어져 있습니다. 표에서 1로 이루어진 가장 큰 정사각형을 찾아 넓이를 return 하는 solution 함수를 완성해 주세요. (단, 정사각형이란 축에 평행한 정사각형을 말합니다.)
 예를 들어
 1  2  3  4
 0  1  1  1
 1  1  1  1
 1  1  1  1
 0  0  1  0
 가 있다면 가장 큰 정사각형은
 1  2  3  4
 0  1  1  1
 1  1  1  1
 1  1  1  1
 0  0  1  0
 가 되며 넓이는 9가 되므로 9를 반환해 주면 됩니다.
 
 #### 제한사항
 표(board)는 2차원 배열로 주어집니다.
 표(board)의 행(row)의 크기 : 1,000 이하의 자연수
 표(board)의 열(column)의 크기 : 1,000 이하의 자연수
 표(board)의 값은 1또는 0으로만 이루어져 있습니다.
 */


/*
 가장 처음에는 한 해당 위치를 시작으로 n x n 개의 배열이 1로 채워져있는지를 확인하고자 하였다.
하지만, 실패가 나오고, 효율성 측면에서도 매우 부족하여  변경하였다.
 
 여러 고민하다 좀 참고를 했는데, 2차원 배열을 순서대로 순회하며 왼쪽 / 왼쪽 위 / 위쪽 중 작은 수 + 1로 만들 수 있다는 것을 알 수 있었다.
 +1인것은 혼자만 가능할때가 딱 1인 것이고, 가장 작은 수가 2라는 것은 이전 수 ( 왼/왼위/위 ) 모두의 ( 왼/왼위/위 )가 1로 최소 1이상으로 최워져있다는 것을 의미하기 때문에 가능한 정시각형의 크기를 나타낼 수 있다.
 
 [참고](https://soobarkbar.tistory.com/164)
 
 보고 구현을 했으나, 배열의 인덱스가 벗어나는 문제가 생겨 최초에는 안전하게 접근하기 위해 subscript 를 추가로 구현했다.
 그러나 이번에는 효율성에서 문제가 발생하였다.
 
 하여 고민해본 결과 배열의 맨 왼쪽, 맨 위쪽은 굳이 확인하지 않아도 1, 0 밖에 나올 수 없어 확인하지 않아도 된다.
 따라서 해당 부분을 수정하였다. 또 배열의 길이가 탐색할 2보다 작을때, index 1이 존재하지 않을 예외 사항이 있기 때문에 해당 부분 또한 구현해주었다.
 효율성과 정확성 테스트 통화구 safety 하게 접근하는 것에 대한 비용을 테스트 해보았는데 제법 많은 비용을 소비함을 알 수 있었다.
 */

func solution(_ board: [[Int]]) -> Int {
  var maxValue = 0
  var board = board
  guard board.count > 1 else { return 1 }
  

  for column in 1..<board.count {
    for row in 1..<board[column].count {
      guard board[column][row] > 0 else { continue }
      
      let leftUp = board[column-1][row-1]
      let left = board[column][row-1]
      let up = board[column-1][row]
      
      let _min = min(leftUp, left, up)
      board[column][row] = _min+1
      
      maxValue = max(_min+1, maxValue)
    }
  }
  
  return maxValue*maxValue
}

extension Collection where Index == Int {
  subscript(safe index: Int) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

extension Collection where Element: Collection, Index == Int, Element.Index == Int {
  subscript(safe index: (Int, Int)) -> Element.Element? {
    self[safe: index.0]?[safe: index.1]
  }
}


print(
  solution([[0,1,1,1],[1,1,1,1],[1,1,1,1],[0,0,1,0]])
)
print(
  solution([[0,0,1,1],[1,1,1,1]])
)

/*
func solution(_ board: [[Int]]) -> Int {
  var maxValue = 0
  var board = board
  
  
  for column in board.indices {
    for row in board[column].indices {
      guard board[column][row] > 0 else { continue }
      
      let leftUp = board[safe: (column-1, row-1)]
      let left = board[safe: (column, row-1)]
      let up = board[safe: column-1, row)]
      
      let _min = min(leftUp, left, up)
      board[column][row] = _min+1
      
      maxValue = max(_min+1, maxValue)
    }
  }
  
  return maxValue*maxValue
}
*/

func __solution(_ board:[[Int]]) -> Int {
  var n = 1
  
  for column in board.indices {
    for row in board[column].indices {
      var length = 1
      
      while true {
        if board[safe: column+length]?[safe: row+length] == nil { break }
        if board[column..<(column+length)].allSatisfy({ $0[row..<(row+length)].allSatisfy({ $0 == 1 })}) {
          length += 1
          n = max(length, n)
        } else {
          break
        }
      }
    }
    
  }
  
  return n*n
}
