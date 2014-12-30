//
//  PhotoDetailController.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class PhotoDetailController: UIViewController, UIGestureRecognizerDelegate {

  let imageView = UIImageView()
  let releaseDistance: CGFloat = 130
  let backgroundAlpha: CGFloat = 0.85

  var originalCenter = CGPointZero

  var tap: UITapGestureRecognizer?
  var pan: UIPanGestureRecognizer?

  var photo: PhotoModel?

  var settledImageFrame: CGRect {
    let width = view.bounds.size.width
    let height = view.bounds.size.height
    return CGRect(x: 0, y: (height - width) / 2, width: width, height: width)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = backgroundColorForDistance(0)

    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    imageView.userInteractionEnabled = true
    view.addSubview(imageView)

    if let url = photo?.imagePath.relativePath {
      imageView.image = UIImage(contentsOfFile: url)
    }

    imageView.frame = settledImageFrame

    let tap = UITapGestureRecognizer(target: self, action: "tapDismiss:")
    tap.delegate = self
    view.addGestureRecognizer(tap)
    self.tap = tap

    let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
    pan.delegate = self
    view.addGestureRecognizer(pan)
    self.pan = pan
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  // MARK: Utility

  func backgroundColorForDistance(d: CGFloat) -> UIColor {
    let alpha = backgroundAlpha - min(d / releaseDistance, 1) / 2.0
    return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
  }

  func resetImageView() {
    UIView.animateWithDuration(0.25,
        delay: 0,
        usingSpringWithDamping: 0.8,
        initialSpringVelocity: 0.8,
        options: .BeginFromCurrentState,
        animations: {
            self.imageView.frame = self.settledImageFrame
            self.view.backgroundColor = self.backgroundColorForDistance(0)
    }, completion: nil)
  }

  // MARK: Gestures

  func tapDismiss(recognizer: UITapGestureRecognizer) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    let translation = recognizer.translationInView(view)
    let newCenter = CGPoint(x: translation.x + originalCenter.x, y: translation.y + originalCenter.y)

    let dx = newCenter.x - originalCenter.x
    let dy = newCenter.y - originalCenter.y
    let distance = sqrt(pow(dx, 2.0) + pow(dy, 2.0))

    if recognizer.state == .Began {
      originalCenter = imageView.center
    } else if recognizer.state == .Changed {
      imageView.center = newCenter

      view.backgroundColor = backgroundColorForDistance(distance)
    } else {
      if distance > releaseDistance {
        dismissViewControllerAnimated(true, completion: nil)
      } else {
        resetImageView()
      }
    }
  }

  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

}
