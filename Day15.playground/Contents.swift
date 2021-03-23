import Foundation

/*:
 ### [멀쩡한 사각형](https://programmers.co.kr/learn/courses/30/lessons/62048)
 
 가로 길이가 Wcm, 세로 길이가 Hcm인 직사각형 종이가 있습니다. 종이에는 가로, 세로 방향과 평행하게 격자 형태로 선이 그어져 있으며, 모든 격자칸은 1cm w 1cm 크기입니다. 이 종이를 격자 선을 따라 1cm × 1cm의 정사각형으로 잘라 사용할 예정이었는데, 누군가가 이 종이를 대각선 꼭지점 2개를 잇는 방향으로 잘라 놓았습니다. 그러므로 현재 직사각형 종이는 크기가 같은 직각삼각형 2개로 나누어진 상태입니다. 새로운 종이를 구할 수 없는 상태이기 때문에, 이 종이에서 원래 종이의 가로, 세로 방향과 평행하게 1cm × 1cm로 잘라 사용할 수 있는 만큼만 사용하기로 하였습니다.
 가로의 길이 W와 세로의 길이 H가 주어질 때, 사용할 수 있는 정사각형의 개수를 구하는 solution 함수를 완성해 주세요.
 
 #### 제한사항
 W, H : 1억 이하의 자연수
 */

func test(_ q: (Int, Int), _ a: Int64) {
  let answer = solution(q.0, q.1)
  print(answer)
  if answer == a {
    print("정답.")
  } else {
    print("오답.")
  }
}

/*:
 망가진 블럭의 개수를 찾는 규칙을 구해야 한다.
 예시에서 8 / 12일때에는 16개이다.
 그럼 2 / 3 일때에는 ? 4개
 3 / 3 일때는 3개.
 w + h - gcd 만큼 망가진다.
 
 */

func gcd(_ x: Int, _ y: Int) -> Int {
  if y == 0 {
    return x
  } else {
    return gcd(y, x%y)
  }
}

func solution(_ w:Int, _ h:Int) -> Int64{
  let _gcd = w > h ? gcd(w, h) : gcd(h, w)
  return Int64(w*h - (w+h-_gcd))
}

test((8, 12), 80)
