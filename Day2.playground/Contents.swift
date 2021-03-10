import Foundation

/*:
 
 ##### [스킬트리](https://programmers.co.kr/learn/courses/30/lessons/49993)
 
 선행 스킬이란 어떤 스킬을 배우기 전에 먼저 배워야 하는 스킬을 의미한다.
 
 예를 들어 선행 스킬 순서가 스파크 → 라이트닝 볼트 → 썬더일때, 썬더를 배우려면 먼저 라이트닝 볼트를 배워야 하고, 라이트닝 볼트를 배우려면 먼저 스파크를 배워야 합니다.
 위 순서에 없는 다른 스킬(힐링 등)은 순서에 상관없이 배울 수 있습니다. 따라서 스파크 → 힐링 → 라이트닝 볼트 → 썬더와 같은 스킬트리는 가능하지만, 썬더 → 스파크나 라이트닝 볼트 → 스파크 → 힐링 → 썬더와 같은 스킬트리는 불가능합니다.
 선행 스킬 순서 skill과 유저들이 만든 스킬트리1를 담은 배열 skill_trees가 매개변수로 주어질 때, 가능한 스킬트리 개수를 return 하는 solution 함수를 작성해주세요.
 
 ##### 제한 조건
 스킬은 알파벳 대문자로 표기하며, 모든 문자열은 알파벳 대문자로만 이루어져 있습니다.
 스킬 순서와 스킬트리는 문자열로 표기합니다.
 예를 들어, C → B → D 라면 "CBD"로 표기합니다
 선행 스킬 순서 skill의 길이는 1 이상 26 이하이며, 스킬은 중복해 주어지지 않습니다.
 skill_trees는 길이 1 이상 20 이하인 배열입니다.
 skill_trees의 원소는 스킬을 나타내는 문자열입니다.
 skill_trees의 원소는 길이가 2 이상 26 이하인 문자열이며, 스킬이 중복해 주어지지 않습니다.
 
 입출력 예
 skill : "CBD"
 skill_trees : ["BACDE", "CBADF", "AECB", "BDA"]
 return : 2
 */



/*:
 내가 생각한 풀이 방법:
 선행 스킬을 찾는 함수 : findDependency(_:) , 가능 한지 확인하는 함수 validity(_:) 를 만들어 filter 함.
 가능한지 확인은 선행 스킬이 존재하지 않거나, 선행 스킬의 인덱스가 더 클 경우를 판단하였음.
 */
func solution(_ skill:String, _ skill_trees:[String]) -> Int {
  let skills = Array(skill)
  
  //: 해당 인덱스가 존재하고, 첫번째가 아닌 경우에 통과, 아닐 때에는 nil
  func findDependency(_ _skill: Character) -> Character? {
    if let _index = skills.firstIndex(of: _skill),
       _index != 0 {
      return skills[_index-1]
    } else {
      return nil
    }
  }
  
  /*: 가능한지 확인.
   depenency 가 없을 때: continue,
   dependency_index 가 없거나, 순서가 맞지 않을 때, return false
   */
  func validity(_ _skill: String) -> Bool {
    let __skill = Array(_skill)
    
    for (i, c) in __skill.enumerated() {
      guard let dependency = findDependency(c) else { continue }
      let _dependency = __skill.firstIndex(of: dependency)
      guard let _d = _dependency, _d < i else { return false }
    }
    return true
  }
  
  return skill_trees.filter { validity($0) }.count
}


solution("CBD", ["BACDE", "CBADF", "AECB", "BDA"])


/*:
 좋아요 수가 가장 많았던 정답.
 선행스킬 외 다른 스킬은 순서가 상관 없기 때문에 선행 스킬에 해당하는 문자열만 먼저 거름. (alza)
 선행스킬만 거른 문자열이 skill과 순서가 일치하는지 확인.
 starts(with:) 를 사용한 이유: CBD 일때 CB 는 가능, BD 는 물가능.
 따라서 s 가 alza 로 시작하는지 확인함.
 */
func solution2(_ skill:String, _ skill_trees:[String]) -> Int {
  
  func available(_ s: String, _ t: String) -> Bool {
    let alza = t.filter { s.contains($0) }
    return s.starts(with: alza)
  }
  
  return skill_trees.filter { available(skill, $0) }.count
}
