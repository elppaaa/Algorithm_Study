//
//  main.swift
//  Boilerplate
//
//  Created by JK on 2021/04/09.
//

import Foundation

print("Hello, World!")


public func bench(benchFunc: () -> ()) {
  let startTime = CFAbsoluteTimeGetCurrent()
  benchFunc()
  let processTime = CFAbsoluteTimeGetCurrent() - startTime
  print("Process Time = \(processTime)")
}


