//: [Previous](@previous)

import Foundation

//: ## Define Traits

protocol Flyer {
  func fly()
}

protocol TimeTraveler {
  var currentDate: Date { get set }
  mutating func travelTo(date: Date)
}

protocol SpaceTraveler {
  func travelTo(location: String)
}

protocol Named {
  var name: String { get }
}

protocol Human: Named {
  var countryOfOrigin: String? { get }
  init(name: String, countryOfOrigin: String?)
}

protocol Alien: Named {
  var species: String { get }
}

protocol Quotable {
  var catchPhrases: [String] { get }
  func randomQuote() -> String
}

//: ## Provide Default Implementations

extension Flyer {
  func fly() {
    print("I believe I can flyyyyy ♬")
  }
}

extension TimeTraveler {
  mutating func travelTo(date: Date) {
    currentDate = date
  }
}

extension SpaceTraveler {
  func travelTo(location: String) {
    print("Let's go to \(location)!")
  }
}

extension Named {
  func sayHello() {
    print("Hello, I am \(name)")
  }
}

extension Quotable {
  func randomQuote() -> String {
    return catchPhrases[Int(arc4random_uniform(UInt32(catchPhrases.count)))]
  }
}

extension Human {
  init(name: String, countryOfOrigin: String? = nil) {
    self.init(name: name, countryOfOrigin: countryOfOrigin)
  }
}

// For types that are both Named and Quotable
extension Named where Self: Quotable {
  func sayHello() {
    print("Hello, I am \(name). \(randomQuote())")
  }
}

// For types that are both Human and Alien
extension Human where Self: Alien {
  func sayHello() {
    print("I'm \(name) and I'm half Human, half \(species)")
  }
}

//: ## Define the Characters

struct DoctorWho: Alien, TimeTraveler, SpaceTraveler, Quotable {
  var currentDate = Date()
  let name = "The Doctor"
  let species = "Gallifreyan"
  let catchPhrases: [String]
}

struct DocEmmettBrown: Human, TimeTraveler {
  var currentDate = Date()
  let name = "Emmett Brown"
  let countryOfOrigin: String? = "USA"
}

struct Superman: Alien, Flyer, SpaceTraveler {
  let name = "Clark Kent"
  let species = "Kryptonian"
}

struct IronMan: Human, Flyer {
  let name = "Tony Stark"
  let countryOfOrigin: String? = "USA"
  func fly() {
    print("J.A.R.V.I.S., start the thrusters!")
  }
}

struct Astraunaut: Named, SpaceTraveler {
  let name: String
}

struct MilleniumFalconPilot: Named, SpaceTraveler {
  let name: String
}

struct Spock: Human, Alien, SpaceTraveler {
  let name = "Spock"
  let countryOfOrigin: String? = nil
  let species = "Vulcan"
}

//: ## Create People!

let mattSmith = DoctorWho(currentDate: Date(timeIntervalSince1970: 1270317600),
                          catchPhrases: ["Geronimo!", "Come along, Pond!"])
mattSmith.sayHello()
mattSmith.travelTo(location: "Trenzalore")

let davidTennant = DoctorWho(currentDate: Date(),
                             catchPhrases: ["Allons-y!", "Wibbly Wobbley Timey Wimey.", "I don't wanna go!"])
davidTennant.sayHello()
davidTennant.travelTo(location: "Skaro")

let clark = Superman()
clark.fly()

let tony = IronMan()
tony.fly()

let spock = Spock()
spock.name
spock.species
spock.sayHello()

//: [Next](@next)
