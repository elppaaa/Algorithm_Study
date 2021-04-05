import Foundation

public func bench(benchFunc: () -> ()) {
  let startTime = CFAbsoluteTimeGetCurrent()
  benchFunc()
  let processTime = CFAbsoluteTimeGetCurrent() - startTime
  print("Process Time = \(processTime)")
}
