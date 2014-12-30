//
//  LoadingModal.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class LoadingModal: UIView {

  let blurEffect = UIBlurEffect(style: .Light)
  var blurView: UIVisualEffectView

  var preferredSize: CGSize {
    return CGSize(width: 200, height: 200)
  }

  override init(frame: CGRect) {
    blurView = UIVisualEffectView(effect: blurEffect)
    super.init(frame: frame)
    config()
  }

  required init(coder aDecoder: NSCoder) {
    blurView = UIVisualEffectView(effect: blurEffect)
    super.init(coder: aDecoder)
    config()
  }

  func config() {
    addSubview(blurView)
    layer.cornerRadius = 10
    clipsToBounds = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    blurView.frame = bounds
  }

  func showInView(view: UIView) {
    let size = preferredSize
    let center = CGPoint(x: CGRectGetMidX(view.bounds), y: CGRectGetMidY(view.bounds))
    frame = CGRect(x: center.x - size.width/2, y: center.y - size.height/2, width: size.width, height: size.height)
    view.addSubview(self)
  }

  func hide() {
    removeFromSuperview()
  }

}
