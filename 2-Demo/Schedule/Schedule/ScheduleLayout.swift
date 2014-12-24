//
//  ScheduleLayout.swift
//  Schedule
//
//  Created by Mic Pringle on 24/11/2014.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ScheduleLayout: UICollectionViewLayout {
  
  // MARK: UICollectionViewLayout
  
  private lazy var dataSource: ScheduleDataSource = {
    return self.collectionView!.dataSource as ScheduleDataSource
  }()
  
  override func collectionViewContentSize() -> CGSize {
    let hoursInSchedule = CGFloat(dataSource.numberOfHoursInSchedule)
    let height = CGRectGetHeight(collectionView!.bounds) - collectionView!.contentInset.top
    let width = hoursInSchedule * dataSource.widthPerHour
    return CGSizeMake(width, height)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    let attributes = NSMutableArray()
    
    let itemIndexPaths = dataSource.indexPathsOfScheduleItems()
    for indexPath in itemIndexPaths {
      let itemAttributes = layoutAttributesForItemAtIndexPath(indexPath as NSIndexPath)
      attributes.addObject(itemAttributes)
    }
    
    return attributes
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
    let session = dataSource.sessionForIndexPath(indexPath)
    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
    attributes.frame = frameForSession(session, atIndexPath: indexPath)
    return attributes
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
     return true
  }
  
  // MARK: Private Utilities
    
  private func frameForSession(session: NSDictionary, atIndexPath indexPath: NSIndexPath) -> CGRect {
    let heightPerTrack = collectionViewContentSize().height / CGFloat(dataSource.numberOfTracksInSchedule)
    let hour = dataSource.floatValueForKey("Hour", inSession: session)
    let offset = dataSource.floatValueForKey("Offset", inSession: session)
    let length = dataSource.floatValueForKey("Length", inSession: session)
    let width = dataSource.widthPerHour * CGFloat(length)
    let x = (CGFloat(hour) * dataSource.widthPerHour) + (dataSource.widthPerHour * CGFloat(offset))
    let y = heightPerTrack * CGFloat(indexPath.item)
    let frame = CGRectMake(x, y, width, heightPerTrack)
    return frame
  }
}
