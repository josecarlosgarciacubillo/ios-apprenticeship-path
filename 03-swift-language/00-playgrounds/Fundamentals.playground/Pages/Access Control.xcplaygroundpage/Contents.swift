struct TrackedString {
  private(set) var numberOfEdits = 0
  var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
}

var ts = TrackedString()
ts.numberOfEdits
ts.value = "Dev Life"
ts.numberOfEdits
