//
//  FullscreenDismissAnimator.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

class FullscreenDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  func transitionDuration(ctx: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  func animateTransition(ctx: UIViewControllerContextTransitioning) {
    ctx.completeTransition(true)
  }
}