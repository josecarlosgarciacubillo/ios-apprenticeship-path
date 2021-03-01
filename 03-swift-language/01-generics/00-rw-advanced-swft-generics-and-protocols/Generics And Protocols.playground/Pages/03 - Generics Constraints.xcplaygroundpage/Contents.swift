// Same
// func add<T>(_ a: T, _ b: T) -> T where T: Numeric {
// func add<T: Numeric>(_ a: T, _ b: T) -> T {

@inlinable func add<T: Numeric>(_ a: T, _ b: T) -> T {
  return a + b
}

add(3, 4)
add(3.0, 4.0)
add(UInt8(20), UInt8(32))
