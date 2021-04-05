import UIKit
import XCTest

/*:
 
 **func combination<T>(_ array: [T], n: Int) -> [[T]]**
 
 배열에서 n개의 요소로 이루어진 조합을 생성한다.

 스택을 이용해 dfs 방식으로 순회하며 조합을 생성한다.
 괜찮다고 생각했으나, loop 횟수가 많아 성능상의 문제가 있음.
 
 */
func combination<T>(_ array: [T], n: Int) -> [[T]] {
  var stack = [(value: [T], index: Int)]()
  var result = [[T]]()
  
  stack.append( ([array[0]], 0) )
  stack.append( ([], 0) )
  
  while !stack.isEmpty {
    var (value, index) = stack.popLast()!
    index += 1
    
    if value.count == n { result.append(value); continue }
    if index == array.count { continue }
    
    stack.append( (value + [array[index]], index) )
    stack.append( (value, index) )
  }
  
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
//Process Time = 45.67280197143555
