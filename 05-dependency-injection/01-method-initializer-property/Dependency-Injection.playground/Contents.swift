protocol Propulsion {
  func move()
}

// Class tightly coupled
class Vehicle {
  var engine: Propulsion
  
  init() {
    engine = RaceCarEngine()
  }
  
  func forward() {
    engine.move()
  }
}

class RaceCarEngine: Propulsion {
  func move() {
    print("Vrrrooooommm!!")
  }
}

var car = Vehicle()
car.forward()

// Class NOT tightly coupled
class VehicleInjected {
  var engine: Propulsion // Protocol as a type
  
  init(engine: Propulsion) {
    self.engine = engine
  }
  
  func forward() {
    engine.move()
  }
}

let fastEngine = RaceCarEngine()
var carInjected = VehicleInjected(engine: fastEngine)
carInjected.forward()

class RocketEngine: Propulsion {
  func move() {
    print("3-2-1... IGNITION!... PPPPSSSSCHHHHOOOOOOOOOMMMMMM!!!")
  }
}

let rocket = RocketEngine()
var spaceship = VehicleInjected(engine: rocket)
spaceship.forward()

