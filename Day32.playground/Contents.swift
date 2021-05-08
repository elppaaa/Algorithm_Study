/*:
 ### [뉴스 클러스터링](https://programmers.co.kr/learn/courses/30/lessons/17677)

 여러 언론사에서 쏟아지는 뉴스, 특히 속보성 뉴스를 보면 비슷비슷한 제목의 기사가 많아 정작 필요한 기사를 찾기가 어렵다. Daum 뉴스의 개발 업무를 맡게 된 신입사원 튜브는 사용자들이 편리하게 다양한 뉴스를 찾아볼 수 있도록 문제점을 개선하는 업무를 맡게 되었다.

 개발의 방향을 잡기 위해 튜브는 우선 최근 화제가 되고 있는 "카카오 신입 개발자 공채" 관련 기사를 검색해보았다.

 카카오 첫 공채..'블라인드' 방식 채용
 카카오, 합병 후 첫 공채.. 블라인드 전형으로 개발자 채용
 카카오, 블라인드 전형으로 신입 개발자 공채
 카카오 공채, 신입 개발자 코딩 능력만 본다
 카카오, 신입 공채.. "코딩 실력만 본다"
 카카오 "코딩 능력만으로 2018 신입 개발자 뽑는다"

 기사의 제목을 기준으로 "블라인드 전형"에 주목하는 기사와 "코딩 테스트"에 주목하는 기사로 나뉘는 걸 발견했다. 튜브는 이들을 각각 묶어서 보여주면 카카오 공채 관련 기사를 찾아보는 사용자에게 유용할 듯싶었다.
 유사한 기사를 묶는 기준을 정하기 위해서 논문과 자료를 조사하던 튜브는 "자카드 유사도"라는 방법을 찾아냈다.
 자카드 유사도는 집합 간의 유사도를 검사하는 여러 방법 중의 하나로 알려져 있다. 두 집합 A, B 사이의 자카드 유사도 J(A, B)는 두 집합의 교집합 크기를 두 집합의 합집합 크기로 나눈 값으로 정의된다.
 예를 들어 집합 A = {1, 2, 3}, 집합 B = {2, 3, 4}라고 할 때, 교집합 A ∩ B = {2, 3}, 합집합 A ∪ B = {1, 2, 3, 4}이 되므로, 집합 A, B 사이의 자카드 유사도 J(A, B) = 2/4 = 0.5가 된다. 집합 A와 집합 B가 모두 공집합일 경우에는 나눗셈이 정의되지 않으니 따로 J(A, B) = 1로 정의한다.
 자카드 유사도는 원소의 중복을 허용하는 다중집합에 대해서 확장할 수 있다. 다중집합 A는 원소 "1"을 3개 가지고 있고, 다중집합 B는 원소 "1"을 5개 가지고 있다고 하자. 이 다중집합의 교집합 A ∩ B는 원소 "1"을 min(3, 5)인 3개, 합집합 A ∪ B는 원소 "1"을 max(3, 5)인 5개 가지게 된다. 다중집합 A = {1, 1, 2, 2, 3}, 다중집합 B = {1, 2, 2, 4, 5}라고 하면, 교집합 A ∩ B = {1, 2, 2}, 합집합 A ∪ B = {1, 1, 2, 2, 3, 4, 5}가 되므로, 자카드 유사도 J(A, B) = 3/7, 약 0.42가 된다.
 이를 이용하여 문자열 사이의 유사도를 계산하는데 이용할 수 있다. 문자열 "FRANCE"와 "FRENCH"가 주어졌을 때, 이를 두 글자씩 끊어서 다중집합을 만들 수 있다. 각각 {FR, RA, AN, NC, CE}, {FR, RE, EN, NC, CH}가 되며, 교집합은 {FR, NC}, 합집합은 {FR, RA, AN, NC, CE, RE, EN, CH}가 되므로, 두 문자열 사이의 자카드 유사도 J("FRANCE", "FRENCH") = 2/8 = 0.25가 된다.
 */


import Foundation

func test<T: Comparable>(_ q: T, _ a: T) {
  print(q)
  if q == a { print ("정답") }
  else { print ("오답") }
}
/*:
 문자 출현 개수를 세기 위해 딕셔너리를 이용해 개수를 저장합니다.

 Character.isLetter 를 이용해 두 글자가 모두 문자인지 확인힙니다.
 딕셔너리를 확인해 개수를 셉니다.

 둘다 동일한 문자열을 포함할때, 두개 중 큰수가 합집합, 작은 수가 교집합이라고 할 수 있습니다.
 교집합 수 / 합 집합 수를 각각 intersection, union 에 담습니다.

 각 문자열에서만 존재하는 것도 합집합에 추가합니다.

 intersection, union 이 모두 0인 경우는 유사도가 1로 65535 를 바로 반환합니다.
 이외의 경우 계산하여 반환합니다.

 */
func solution(_ str1:String, _ str2:String) -> Int {
  let str1 = str1.lowercased().map { $0 }
  let str2 = str2.lowercased().map { $0 }

  var str1Count = [String: Int]()
  var str2Count = [String: Int]()

  var union = 0
  var intersection = 0

  for i in 0..<str1.count-1 {
    if str1[i].isLetter && str1[i+1].isLetter {
      let key = String(str1[i..<i+2])
      if let val = str1Count[key] {
        str1Count[key] = val + 1
      } else {
        str1Count[key] = 1
      }
    }
  }

  for i in 0..<str2.count-1 {
    if str2[i].isLetter && str2[i+1].isLetter {
      let key = String(str2[i..<i+2])

      if let val = str2Count[key] {
        str2Count[key] = val + 1
      } else {
        str2Count[key] = 1
      }
    }
  }


  for (k, v) in str2Count {
    if let val = str1Count[k] {
      union += max(val, v) // 합집합
      intersection += min(val, v) // 교집합
      str1Count.removeValue(forKey: k)
    } else {
      union += v // str2 only
    }
  }

  // str1 only
  union += str1Count.reduce(0) { (number, dict) in return number + dict.value }

  if intersection == 0 && union == 0 { return 65536 }

  return Int(floorf(Float(intersection)/Float(union) * 65536))
}

test( solution("FRANCE", "french"), 16384 )
test( solution("handshake", "shake hands"), 65536 )
test( solution("aa1+aa2", "AAAA12"), 43690 )
test( solution("E=M*C^2", "e=m*c^2"), 65536 )





