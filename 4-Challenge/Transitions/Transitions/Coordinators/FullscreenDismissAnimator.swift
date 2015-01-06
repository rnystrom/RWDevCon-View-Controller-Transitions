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

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotosController
    let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotoDetailController
    let duration = transitionDuration(transitionContext)

    UIView.animateWithDuration(duration,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.2,
      options: .BeginFromCurrentState,
      animations: {
        from.imageView.frame = to.selectedViewOriginRect
      }, completion: { finished in
        to.selectedView?.hidden = false
        from.view.removeFromSuperview()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })

    UIView.animateWithDuration(duration * 0.2, animations: {
      from.view.backgroundColor = UIColor.clearColor()
    })
  }
}