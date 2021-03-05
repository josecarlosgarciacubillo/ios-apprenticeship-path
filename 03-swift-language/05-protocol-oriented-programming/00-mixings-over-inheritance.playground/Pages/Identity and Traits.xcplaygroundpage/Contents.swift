//: This Playground demos the code from [this article on my "Crunchy Development" Blog](http://alisoftware.github.io/swift/protocol/2015/11/08/mixins-over-inheritance/)

import Foundation
//: ## Protocols with Default Implementation

protocol Flyer {
  func fly()
}

protocol TimeTraveler {
  var currentDate: Date { get set }
  mutating func travelTo(date: Date)
}

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

//: ## One identity, multiple abilities

class Character {
  var name: String
  init(name: String) {
    self.name = name
  }
}

class Human: Character {
  var countryOfOrigin: String?
  init(name: String, countryOfOrigin: String? = nil) {
    self.countryOfOrigin = countryOfOrigin
    super.init(name: name)
  }
}

class Alien: Character {
  let species: String
  init(name: String, species: String) {
    self.species = species
    super.init(name: name)
  }
}

class TimeLord: Alien, TimeTraveler {
  var currentDate = Date()
  init() {
    super.init(name: "I'm the Doctor", species: "Gallifreyan")
  }
}

class DocEmmettBrown: Human, TimeTraveler {
  var currentDate = Date()
  init() {
    super.init(name: "Emmett Brown", countryOfOrigin: "USA")
  }
}

class Superman: Alien, Flyer {
  init() {
    super.init(name: "Clark Kent", species: "Kryptonian")
  }
}

class IronMan: Human, Flyer {
  init() {
    super.init(name: "Tony Stark", countryOfOrigin: "USA")
  }
}

let tony = IronMan()
tony.fly()
tony.name

let clark = Superman()
clark.fly()
clark.species

var docBrown = DocEmmettBrown()
docBrown.travelTo(date: Date(timeIntervalSince1970: 499161600))
docBrown.name
docBrown.countryOfOrigin
docBrown.currentDate

var doctorWho = TimeLord()
doctorWho.travelTo(date: Date(timeIntervalSince1970: 1303484520))
doctorWho.species
doctorWho.currentDate


//: ## An adventure in Space and Time

protocol SpaceTraveler {
  func travelTo(location: String)
}

extension SpaceTraveler {
  func travelTo(location: String) {
    print("Let's go to \(location)!")
  }
}

extension TimeLord: SpaceTraveler {}
extension Superman: SpaceTraveler {}

doctorWho.travelTo(location: "Trenzalore")

//: ## Let's invite more people

let amy = Human(name: "Amelia Pond", countryOfOrigin: "UK") // Come along, Pond
// Damn, isn't she not a Time and Space Traveler too? Which doesn't make her a TimeLord though

class Astraunaut: Human, SpaceTraveler {}
let neilArmstrong = Astraunaut(name: "Neil Armstrong", countryOfOrigin: "USA")
let laika = Astraunaut(name: "Laïka", countryOfOrigin: "Russia") // Wait, that's a Dog, right?

class MilleniumFalconPilot: Human, SpaceTraveler {}
let hanSolo = MilleniumFalconPilot(name: "Han Solo")
let chewbacca = MilleniumFalconPilot(name: "Chewie") // Wait, you said Human?!

class Spock: Alien, SpaceTraveler {
  init() {
    super.init(name: "Spock", species: "Vulcan") // Woops not 100% right
  }
}

//: [Next](@next)

