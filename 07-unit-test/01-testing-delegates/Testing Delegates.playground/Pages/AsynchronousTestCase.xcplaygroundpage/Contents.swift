import XCTest

struct Tweet: Equatable {
  let from: String
  let content: String
}

protocol TwitterAPIDelegate: AnyObject {
  var didRetrieveTweetsClosure: (([Tweet]) -> Void)? { get }
  func didRetrieveTweets(_ tweets: [Tweet])
}

class TwitterAPI {
  weak var delegate: TwitterAPIDelegate?
  
  func getTweets() {
    let tweets = [Tweet(from: "slashmodev", content: "Testing Delegates in Swift")]
    delegate?.didRetrieveTweetsClosure?(tweets)
  }
}

class AsynchronousTestCase: XCTestCase {

  class TwitterAPIConsumerMock: TwitterAPIDelegate {
    var didRetrieveTweetsClosure: (([Tweet]) -> Void)?
    
    func didRetrieveTweets(_ tweets: [Tweet]) {
      didRetrieveTweetsClosure?(tweets)
    }
  }
  
  func testItNotifiesItsConsumerOnceNewTweetsWereRetrieved() {
    let expectedTweets = [Tweet(from: "slashmodev", content: "Testing Delegates in Swift")]
    let tweetsExpectation = expectation(description: "TwitterAPI retrieved new tweets")
    let twitterAPI = TwitterAPI()
    let consumer = TwitterAPIConsumerMock()
    twitterAPI.delegate = consumer
    consumer.didRetrieveTweetsClosure = { tweets in
      XCTAssertEqual(tweets, expectedTweets)
      tweetsExpectation.fulfill()
    }
    twitterAPI.getTweets()
    waitForExpectations(timeout: 1.0)
  }
}

AsynchronousTestCase.defaultTestSuite.run()
