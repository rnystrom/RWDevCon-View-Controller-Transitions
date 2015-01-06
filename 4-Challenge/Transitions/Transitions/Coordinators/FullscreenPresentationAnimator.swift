//
//  MonthNavigationAnimator.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

class FullscreenPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  var isPresenting = false

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotoDetailController
    let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotosController
    let container = transitionContext.containerView()
    let duration = transitionDuration(transitionContext)

    container.addSubview(to.view)

    let toFrame = to.imageView.frame
    to.imageView.frame = from.selectedViewOriginRect

    UIView.animateWithDuration(duration,
      delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0.2,
      options: .BeginFromCurrentState,
      animations: {
        to.imageView.frame = toFrame
      }, completion: { finished in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })

    from.selectedView?.hidden = true

    let bgColor = to.view.backgroundColor
    to.view.backgroundColor = UIColor.clearColor()

    UIView.animateWithDuration(duration * 0.2, animations: {
      to.view.backgroundColor = bgColor
    })
  }
}