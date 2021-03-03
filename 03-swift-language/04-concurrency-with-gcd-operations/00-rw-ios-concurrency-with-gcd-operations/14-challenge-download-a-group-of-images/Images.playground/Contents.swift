// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Download a Group of Images
let group = DispatchGroup()
let queue = DispatchQueue.global()

let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]
var images: [UIImage] = []
//: Use a dispatch group to download these images and perform these actions when all the images have finished downloading: Print "All done!", show images[0] and terminate the playground.
// Hint 1: How to download one image
let url = URL(string: "\(base)\(ids[0])-jpeg.jpg")!
URLSession.shared.dataTask(with: url) { data, response, error in
  if error == nil, let data = data, let image = UIImage(data: data) {
    images.append(image)
  }
}.resume()

// Dowloader Helper Method
func downloadImage(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
  URLSession.shared.dataTask(with: url) { data, response, error in
    if error == nil, let data = data, let image = UIImage(data: data) {
      images.append(image)
      completion(data, response, error)
    }
  }.resume()
}

func asyncDownloadImage(with url: URL,
                        runQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated),
                        completionQueue: DispatchQueue = DispatchQueue.main,
                        completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
  runQueue.async {
    downloadImage(with: url) { (data, response, error) in
      completionQueue.async {
        completion(data, response, error)
      }
    }
  }
}

// Step 1: Fill in this DispatchGroup wrapper
func dataTask_Group(with url: URL,
                    group: DispatchGroup,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
  group.enter()
  asyncDownloadImage(with: url) { (data, response, error) in
    defer { group.leave() }
    completionHandler(data, response, error)
  }
}

for id in ids {
  guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else { continue }
  // Step 2: Call dataTask_Group
  dataTask_Group(with: url, group: group) { (data, response, error) in
    print("Downloaded image completed...")
  }
}

// Step 3: Fill in group.notify handler
group.notify(queue: queue) {
  print("All done!")
  images[0]
  PlaygroundPage.current.finishExecution()
}
