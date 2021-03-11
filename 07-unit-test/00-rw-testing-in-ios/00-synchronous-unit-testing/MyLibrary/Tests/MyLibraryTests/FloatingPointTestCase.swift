import XCTest
@testable import MyLibrary

final class FloatingPointTestCase: XCTestCase {
  func test_isInteger() {
    let int = CGFloat(1).isInteger
    XCTAssertTrue(int)
  }
  
  func test_isNotInteger() {
    let float = CGFloat(1.0).isInteger
    XCTAssertTrue(float)
  }
}



