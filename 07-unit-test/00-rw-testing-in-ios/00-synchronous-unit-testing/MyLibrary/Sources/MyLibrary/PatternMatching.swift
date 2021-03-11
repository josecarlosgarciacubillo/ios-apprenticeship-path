//
//  File.swift
//  
//
//  Created by Carlos Garcia on 10/03/21.
//

public func ~= <Value>(pattern: (Value) -> Bool, value: Value) -> Bool {
  pattern(value)
}
