//
//  FullscreenPresentationAnimator.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation
import UIKit

class FullscreenPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotoDetailController
    let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotosController
    let container = transitionContext.containerView()
    let duration = transitionDuration(transitionContext)

    container.addSubview(to.view)

    to.view.transform = CGAffineTransformMakeScale(0.1, 0.1)

    UIView.animateWithDuration(duration, animations: {
      to.view.transform = CGAffineTransformIdentity
    }) { finished in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
}