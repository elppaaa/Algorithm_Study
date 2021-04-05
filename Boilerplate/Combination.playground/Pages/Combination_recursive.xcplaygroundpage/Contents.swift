import Foundation

/*
 재귀함수를 이용해 조합을 생성한다. dfs와 유사하게 동작한다. 외부에 배열을 두고 수행된다.
 */

var combinations = [[String]]()

func combination(total: [String], shouldSelect: Int, current index: Int, selected: [String]) {
  if shouldSelect == 0 {
    combinations.append(selected)
  } else if index == total.count {
    return
  } else {
    var newSelected = selected
    newSelected.append(total[index])
    combination(total: total, shouldSelect: shouldSelect-1, current: index+1, selected: newSelected)
    combination(total: total, shouldSelect: shouldSelect, current: index+1, selected: selected)
  }
}

bench {
  for _ in 0..<1000 {
    let str1 = ["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"]
    let str2 = ["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"]
    let str3 = ["XYZ", "XWY", "WXA"]
    let i = Int(arc4random() % 5)
    
    combinations = []
    combination(total: str1, shouldSelect: i, current: 0, selected: [])
    combinations = []
    combination(total: str2, shouldSelect: i, current: 0, selected: [])
    combinations = []
    combination(total: str3, shouldSelect: i, current: 0, selected: [])
  }
}
// Process Time = 12.469045996665955

/* 이것을 클래스로 구성해 보았습니다. 클래스의 비용이 너무 큰 듯. */

class Combination<T> {
  private let array: [T]
  var result: [[T]] = []
  
  init(_ array: [T], n: Int) {
    self.array = array
    run(n: n)
  }
  
  func run(n: Int) {
    combination(shouldSelect: n, current: 0, selected: [])
  }
  
  func combination(shouldSelect: Int, current index: Int, selected: [T]) {
    if shouldSelect == 0 {
      result.append(selected)
    } else if index == array.count {
      return
    } else {
      var newSelected = selected
      newSelected.append(array[index])
      combination(shouldSelect: shouldSelect-1, current: index+1, selected: newSelected)
      combination(shouldSelect: shouldSelect, current: index+1, selected: selected)
    }
  }
}

bench {
  for _ in 0..<1000 {
    let str1 = ["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"]
    let str2 = ["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"]
    let str3 = ["XYZ", "XWY", "WXA"]
    let i = Int(arc4random() % 5)
    
    Combination(str1, n: i).result
    Combination(str2, n: i).result
    Combination(str3, n: i).result
  }
}
// Process Time = 73.64706993103027



/*
 중첩된 함수로 감싸고 일부 수정. 가장 적절한 것으로 판단.
 */
func combination<T>(_ array: [T], n: Int) -> [[T]] {
  let length = array.count
  func combination(_ n: Int, _ index: Int, selected: [T]) {
    if n == 0 {
      result.append(selected)
    } else if index == length {
      return
    } else {
      combination(n-1, index+1, selected: selected + [array[index]])
      combination(n, index+1, selected: selected)
    }
  }
  
  var result = [[T]]()
  combination(n, 0, selected: [])
  
  return result
}

bench {
  for _ in 0..<1000 {
    let str1 = ["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"]
    let str2 = ["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"]
    let str3 = ["XYZ", "XWY", "WXA"]
    let i = Int(arc4random() % 5)
    
    combination(str1, n: i)
    combination(str2, n: i)
    combination(str3, n: i)
  }
}

// Process Time = 9.8960440158844


