import Foundation

protocol Distribution {
  
  associatedtype Value
  
  func sample<G: RandomNumberGenerator>(using generator: inout G) -> Value
  func sample<G: RandomNumberGenerator>(count: Int, using generator: inout G) -> [Value]
}

extension Distribution {
  
  func sample() -> Value {
    var g = SystemRandomNumberGenerator()
    return sample(using: &g)
  }
  
  func sample(count: Int) -> [Value] {
    var g = SystemRandomNumberGenerator()
    return sample(count: count, using: &g)
  }
  
  func sample<G: RandomNumberGenerator>(count: Int, using geretaror: inout G) -> [Value] {
    var g = SystemRandomNumberGenerator()
    return (1...count).map { _ in sample(using: &g) }
  }
}

//////////////////////////////////////////////////////////////////////

struct UniformDistribution: Distribution {
  
  var range: ClosedRange<Int>
  
  func sample<G: RandomNumberGenerator>(using generator: inout G) -> Int {
    return Int.random(in: range, using: &generator)
  }
}

var distribution = UniformDistribution(range: 1...10)
distribution.sample()
