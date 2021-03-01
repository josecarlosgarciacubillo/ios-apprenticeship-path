// MARK: - Final Methods

class Unicorn {
  final func numbersOfHorns() -> Int {
    return 1
  }
}

// If we try to override the method.
/*
class Horse: Unicorn {
  override func numbersOfHorns() -> Int { // ERROR: Instance method overrides a 'final' instance method
    return 0
  }
}
*/

class Pony {
  // WITHOUT final
  func genus() -> String {
    return "Equus"
  }
}


print(Pony().genus())
