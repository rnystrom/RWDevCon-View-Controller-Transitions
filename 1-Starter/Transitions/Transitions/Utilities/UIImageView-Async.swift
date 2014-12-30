//
//  UIImageView-Async.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

private let AsyncImageCache = NSCache()

extension UIImageView {

  func setAsyncImageURL(path: String) {
    if let image = AsyncImageCache .objectForKey(path) as? UIImage {
      self.image = image
      return
    }

    weak var weakSelf = self
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      if let image = UIImage(contentsOfFile: path) {
        AsyncImageCache.setObject(image, forKey: path)
        dispatch_async(dispatch_get_main_queue()) {
          if let strongSelf = weakSelf {
            strongSelf.image = image
          }
        }
      }
    }
  }

}