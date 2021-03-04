// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

protocol Distribution {
  func sample() -> Double
  func sample(count: Int) -> [Double]
}

extension Distribution {
  func sample(count: Int) -> [Double] {
    (1...count).map { _ in sample() }
  }
}

struct UniformDistribution: Distribution {
  var range: ClosedRange<Int>
  
  func sample() -> Double {
    Double(Int.random(in: range))
  }
}

let d10 = UniformDistribution(range: 1...10)
d10.sample(count: 100)
print(d10.sample(count: 1000).reduce(0) { $0 + ($1 == 10 ? 1 : 0) })
