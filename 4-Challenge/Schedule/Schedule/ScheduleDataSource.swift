//
//  ScheduleDataSource.swift
//  Schedule
//
//  Created by Mic Pringle on 21/11/2014.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

typealias CellConfigurationBlock = (cell: ScheduleCell, indexPath: NSIndexPath, session: NSDictionary) -> ()
typealias HeaderConfigurationBlock = (header: ScheduleHeader, indexPath: NSIndexPath, group: NSDictionary, kind: String) -> ()

class ScheduleDataSource: NSObject, UICollectionViewDataSource {
  
  let hourHeaderHeight: CGFloat = 40
  let numberOfTracksInSchedule = 3
  let numberOfHoursInSchedule = 10
  let trackHeaderWidth: CGFloat = 120
  let widthPerHour: CGFloat = 180
  
  var cellConfigurationBlock: CellConfigurationBlock?
  var headerConfigurationBlock: HeaderConfigurationBlock?
  
  private lazy var schedule: NSArray! = {
    let path = NSBundle.mainBundle().pathForResource("Schedule", ofType: "plist")
    return NSArray(contentsOfFile: path!)
  }()
  private let trackHeaderTitles = ["Beginner", "Intermediate", "Advanced"]
  private let hourHeaderTitles = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
  
  // MARK: UICollectionViewDataSource
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return schedule.count
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfSessionsForSection(section).count;
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScheduleCell", forIndexPath: indexPath) as ScheduleCell
    let session = sessionDictionaryForIndexPath(indexPath)
    if let configureBlock = cellConfigurationBlock {
      configureBlock(cell: cell, indexPath: indexPath, session: session)
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ScheduleHeader", forIndexPath: indexPath) as ScheduleHeader
    let group = groupDictionaryForSection(indexPath.section)
    if let configurationBlock = headerConfigurationBlock {
      configurationBlock(header: header, indexPath: indexPath, group: group, kind: kind)
    }
    return header
  }
  
  // MARK: Public Utilites
  
  internal func indexPathsOfHourHeaderViews() -> NSArray {
    let indexPaths = NSMutableArray()
    for item in 0..<numberOfHoursInSchedule {
      let indexPath = NSIndexPath(forItem: item, inSection: 0)
      indexPaths.addObject(indexPath)
    }
    return indexPaths
  }
  
  internal func indexPathsOfScheduleItems() -> NSArray {
    let indexPaths = NSMutableArray()
    for section in 0..<schedule.count {
      let sessions = arrayOfSessionsForSection(section)
      for index in 0..<sessions.count {
          let indexPath = NSIndexPath(forItem: index, inSection: section)
          indexPaths.addObject(indexPath)
      }
    }
    return indexPaths
  }
  
  internal func indexPathsOfTrackHeaderViews() -> NSArray {
    let indexPaths = NSMutableArray()
    for item in 0..<numberOfTracksInSchedule {
      let indexPath = NSIndexPath(forItem: item, inSection: 0)
      indexPaths.addObject(indexPath)
    }
    return indexPaths
  }
    
  internal func sessionForIndexPath(indexPath: NSIndexPath) -> NSDictionary {
    return sessionDictionaryForIndexPath(indexPath)
  }
  
  internal func titleForHourHeaderViewAtIndexPath(indexPath: NSIndexPath) -> String {
    return hourHeaderTitles[indexPath.item]
  }
  
  internal func titleForTrackHeaderViewAtIndexPath(indexPath: NSIndexPath) -> String {
    return trackHeaderTitles[indexPath.item]
  }
  
  internal func floatValueForKey(key: NSString, inSession session: NSDictionary) -> Float {
    let value = session[key] as NSString
    return value.floatValue
  }
  
  // MARK: Private Utilities
  
  private func arrayOfSessionsForSection(section: Int) -> NSArray {
    let groupDictionary = groupDictionaryForSection(section)
    return groupDictionary["Sessions"] as NSArray
  }
  
  private func groupDictionaryForSection(section: Int) -> NSDictionary {
    return schedule[section] as NSDictionary
  }
  
  private func sessionDictionaryForIndexPath(indexPath: NSIndexPath) -> NSDictionary {
    let sessions = arrayOfSessionsForSection(indexPath.section)
    return sessions[indexPath.row] as NSDictionary
  }
  
}