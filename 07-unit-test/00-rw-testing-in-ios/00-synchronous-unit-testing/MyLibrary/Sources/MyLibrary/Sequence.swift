//
//  File.swift
//  
//
//  Created by Carlos Garcia on 10/03/21.
//

public extension Sequence {
  var first: Element? {
    first { _ in true }
  }
}

public extension Sequence where Element: AdditiveArithmetic {
  var sum: Element? {
    guard let first = first else { return nil }
    return dropFirst().reduce(first, +)
  }
}
