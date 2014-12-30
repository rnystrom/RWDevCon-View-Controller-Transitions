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

  func transitionDuration(ctx: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  func animateTransition(ctx: UIViewControllerContextTransitioning) {
    let to = ctx.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotoDetailController
    let from = ctx.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotosController
    let container = ctx.containerView()
    let duration = transitionDuration(ctx)

    container.addSubview(to.view)

    to.view.transform = CGAffineTransformMakeScale(0.1, 0.1)

    UIView.animateWithDuration(duration, animations: {
      to.view.transform = CGAffineTransformIdentity
    }) { finished in
      ctx.completeTransition(!ctx.transitionWasCancelled())
    }
  }
}