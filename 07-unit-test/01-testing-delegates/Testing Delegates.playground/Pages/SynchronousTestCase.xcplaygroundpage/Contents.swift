import XCTest

class SynchronousTestCase: XCTestCase {

  func testItAddsTwoNumbers() {
    // arrange
    let x = 1
    let y = 2
    let expectedSum = 3
    // act
    let result = sum(x, y)
    // assert
    XCTAssertEqual(result, expectedSum)
  }
  
  func sum(_ x: Int, _ y: Int) -> Int {
    x + y
  }
}

SynchronousTestCase.defaultTestSuite.run()
