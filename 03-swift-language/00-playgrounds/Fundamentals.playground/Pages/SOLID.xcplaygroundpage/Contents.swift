// MARK: - Single Responsibility Principle, Open/Closed Principle
protocol Product {
  func price() -> Int
  func name() -> String
}

class FullPriceProduct: Product {
  func price() -> Int {
    return 1000
  }
  
  func name() -> String {
    return "I'm a product"
  }
}

class DiscountedProductDecorator: Product {
  private let decoratedProduct: Product
  
  init(decoratedProduct: Product) {
    self.decoratedProduct = decoratedProduct
  }
  
  func price() -> Int {
    return Int(Float(decoratedProduct.price()) * 0.75)
  }
  
  func name() -> String {
    return decoratedProduct.name()
  }
}

class CheckoutManager {
  func checkout(product: Product) {
    let name = product.name()
    let price = Double(product.price() / 100)
    print("charging customer $\(price) for \(name)")
  }
}

let fullPriceProduct = FullPriceProduct()
let discountedProduct = DiscountedProductDecorator(decoratedProduct: fullPriceProduct)
let checkoutManager = CheckoutManager()
checkoutManager.checkout(product: fullPriceProduct)
checkoutManager.checkout(product: discountedProduct)

// MARK: - Liskov Substitution Principle, Interface Segregation Principle
protocol WorkerInterface {
  func eat()
  func work()
}

class Worker: WorkerInterface {
  func eat() {
    print("worker's eating lunch")
  }
  
  func work() {
    print("worker's working")
  }
}

class Contractor: WorkerInterface {
  func eat() {
    print("contractor's eating lunch")
  }
  
  func work() {
    print("contractor's working")
  }
}

class Manager {
  private let workers: [WorkerInterface]
  
  init(workers: [WorkerInterface]) {
    self.workers = workers
  }
  
  func manage() {
    workers.forEach { (worker: WorkerInterface) in
      worker.work()
    }
  }
}

let worker1 = Worker()
let worker2 = Worker()
let contractor = Contractor()
let manager = Manager(workers: [worker1, worker2, contractor])
manager.manage()

protocol WorkableInterface {
  func work()
}

protocol FeedableInterface {
  func eat()
}

class WorkerDev: WorkableInterface, FeedableInterface {
  func eat() {
    print("worker's eating lunch")
  }
  func work() {
    print("worker's working")
  }
}

class Robot: WorkableInterface {
  func work() {
    print("robot's working")
  }
}
