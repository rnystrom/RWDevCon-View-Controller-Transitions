//
//  PhotoImporter.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import ImageIO

func findPhotos(path: String) -> (photos: [PhotoModel], error: NSError?) {
  let fm = NSFileManager.defaultManager()
  var error: NSError?

  let df = NSDateFormatter()
  df.dateFormat = "yyyy:MM:dd HH:mm:ss"

  typealias PropDictionary = Dictionary<String, AnyObject>

  var photos = [PhotoModel]()

  let options = [(kCGImageSourceShouldCache as String): false]

  if let imageURLs = fm.contentsOfDirectoryAtPath(path, error: &error) as? [String] {
    for fileName in imageURLs {
      if let url = NSURL(fileURLWithPath: path)?.URLByAppendingPathComponent(fileName) {
        if let imageSource = CGImageSourceCreateWithURL(url, nil) {
          if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, options) as? PropDictionary {
            if let exif = imageProperties[kCGImagePropertyExifDictionary] as? PropDictionary {
              if let originalDateString = exif[kCGImagePropertyExifDateTimeOriginal] as? String {
                if let date = df.dateFromString(originalDateString) {
                  photos.append(PhotoModel(title: fileName, imagePath: url, dateTaken: date))
                }
              }
            }
          }
        }
      }
    }
  }

  return (photos, error)
}

func loadPhotos(completion: ([PhotoModel], NSError?) -> Void) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    let path = NSBundle.mainBundle().bundlePath + "/feed_images"
    let result = findPhotos(path)
    dispatch_async(dispatch_get_main_queue()) {
      completion(result.photos, result.error)
    }
  }
}
