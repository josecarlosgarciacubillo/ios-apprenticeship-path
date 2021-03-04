// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Explore Operations
//: An `Operation` represents a 'unit of work', and can be constructed as a `BlockOperation` or as a custom subclass of `Operation`.
//: ## BlockOperation
//: Create a `BlockOperation` to add two numbers
var result: Int?
// TODO: Create and run sumOperation
let sumOperation = BlockOperation {
  result = 2 + 3
  sleep(2)
}
duration {
  sumOperation.start()
}
result

//: Create a `BlockOperation` with multiple blocks:
// TODO: Create and run multiPrinter
let multiPrinter = BlockOperation()
multiPrinter.completionBlock = { print("Finished multiprinting!") }
multiPrinter.addExecutionBlock { print("Hello"); sleep(2) }
multiPrinter.addExecutionBlock { print("my"); sleep(2) }
multiPrinter.addExecutionBlock { print("name"); sleep(2) }
multiPrinter.addExecutionBlock { print("is"); sleep(2) }
multiPrinter.addExecutionBlock { print("Carlos"); sleep(2) }
duration {
  multiPrinter.start()
}

PlaygroundPage.current.finishExecution()
