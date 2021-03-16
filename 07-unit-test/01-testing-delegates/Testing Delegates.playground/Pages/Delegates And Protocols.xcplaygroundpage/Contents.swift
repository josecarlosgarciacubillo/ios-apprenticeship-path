import XCTest

protocol TemperatureManagerDelegate: AnyObject {
  func temperatureManager(_ temperatureManager: TemperatureManager, didUpdateTemperature temperature: Double)
}

class TemperatureManager {
  weak var delegate: TemperatureManagerDelegate?
  
  func startUpdating() {
    // Simulate of continuous update of temperature change.
    DispatchQueue.global().async {
      usleep(100)
      for i in 0..<5 {
        let newTemperature: Double = Double(i * 7)
        DispatchQueue.main.async {
          self.delegate?.temperatureManager(self, didUpdateTemperature: newTemperature)
        }
      }
    }
  }
}

class MockTemperatureManagerDelegate: TemperatureManagerDelegate {
  var temperature: Double?
  private var expectation: XCTestExpectation?
  private let testCase: XCTestCase
  
  init(testCase: XCTestCase) {
    self.testCase = testCase
  }
  
  func expectTemperature() {
    expectation = testCase.expectation(description: "Expect temperature")
  }
  
  // MARK: - TemperatureManagerDelegate
  func temperatureManager(
    _ temperatureManager: TemperatureManager,
    didUpdateTemperature temperature: Double) { // 6
    
    if expectation != nil {
      self.temperature = temperature
    }
    expectation?.fulfill()
    expectation = nil
  }
}

class TemperatureManagerTests: XCTestCase {
  func testTemperature() throws {
    // Arrange
    let mockDelegate = MockTemperatureManagerDelegate(testCase: self)
    let manager = TemperatureManager()
    manager.delegate = mockDelegate
    
    // Act
    mockDelegate.expectTemperature()
    manager.startUpdating()
    
    // Assert
    waitForExpectations(timeout: 1)
    
    let result = mockDelegate.temperature
    XCTAssertEqual(result, 0)
  }
}

TemperatureManagerTests.defaultTestSuite.run()
