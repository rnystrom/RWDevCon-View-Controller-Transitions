//
//  ScheduleViewController.swift
//  Schedule
//
//  Created by Mic Pringle on 24/11/2014.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ScheduleViewController: UICollectionViewController {
  
  // MARK: UIViewController
    
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    collectionView!.collectionViewLayout.invalidateLayout()
  }
  
}
