//
//  File.swift
//  
//
//  Created by Carlos Garcia on 10/03/21.
//

public extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}
