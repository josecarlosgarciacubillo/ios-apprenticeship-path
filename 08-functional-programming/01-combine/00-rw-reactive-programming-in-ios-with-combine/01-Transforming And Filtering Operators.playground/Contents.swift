import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "collect") {
  ["A", "B", "C", "D", "E"].publisher
    .collect(2)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)
}

example(of: "map") {
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  
  [123, 4, 53].publisher
    .map { value -> String in
      formatter.string(for: NSNumber(integerLiteral: value)) ?? ""
    }
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}

example(of: "replaceNil") {
  ["A", nil, "C"].publisher
    .replaceNil(with: "-")
    .map { $0! }
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}

example(of: "replaceEmpty(with:") {
  let empty = Empty<Int, Never>()
  empty
    .replaceEmpty(with: 1)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}

example(of: "scan") {
  var dailyGainLoss: Int {
    .random(in: -10...10)
  }
  
  let august2019 = (0..<22)
    .map { _ in dailyGainLoss }
    .publisher
    
  august2019
    .scan(50) { latest, current in
      max(0, latest + current)
    }
    .sink(receiveValue: { _ in })
    .store(in: &subscriptions)
}

example(of: "flatMap") {
  let charlotte = Chatter(name: "Charlotte", message: "Hi, I'm Charlotte!")
  let james = Chatter(name: "James", message: "Hi, I'm James!")
  let chat = CurrentValueSubject<Chatter, Never>(charlotte)
  
  chat
    .flatMap { $0.message }
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
  
  charlotte.message.value = "Charlotte: How's it going?"
  chat.value = james
  
  james.message.value = "James: Doing great. You?"
  charlotte.message.value = "Charlotte: I'm doing fine, thanks."
}

