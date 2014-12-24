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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let headerNib = UINib(nibName: "ScheduleHeader", bundle: nil)
    collectionView!.registerNib(headerNib, forSupplementaryViewOfKind: "HourHeader", withReuseIdentifier: "ScheduleHeader")
    collectionView!.registerNib(headerNib, forSupplementaryViewOfKind: "TrackHeader", withReuseIdentifier: "ScheduleHeader")
    
    let dataSource = collectionView!.dataSource as ScheduleDataSource
    dataSource.cellConfigurationBlock = {(cell: ScheduleCell, indexPath: NSIndexPath, session: NSDictionary) in
      cell.nameLabel.text = session["Name"] as NSString
    }
    dataSource.headerConfigurationBlock = {(header: ScheduleHeader, indexPath: NSIndexPath, group: NSDictionary, kind: String) in
      if kind == "HourHeader" {
        header.titleLabel.text = dataSource.titleForHourHeaderViewAtIndexPath(indexPath)
      } else if kind == "TrackHeader" {
        header.titleLabel.text = dataSource.titleForTrackHeaderViewAtIndexPath(indexPath)
        if let verticalSeparatorView = header.verticalSeparatorView {
          verticalSeparatorView.hidden = true
        }
      }
    }
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    collectionView!.collectionViewLayout.invalidateLayout()
  }
  
}
