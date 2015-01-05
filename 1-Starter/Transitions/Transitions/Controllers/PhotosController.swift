//
//  PhotosController.swift
//  Transitions
//
//  Created by Ryan Nystrom on 11/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class PhotosController: UICollectionViewController {

  let HeaderIdentifier = "HeaderIdentifier"
  let dateFormatter: NSDateFormatter = {
    let df = NSDateFormatter()
    df.dateFormat = "MMMM dd, yyyy"
    return df
  }()

  var photos = [PhotoModel]()

  override func viewDidLoad() {
    super.viewDidLoad()

    let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20))
    statusBarView.backgroundColor = UIColor(red: 0, green: 104/255.0, blue: 55/255.0, alpha: 1)
    view.addSubview(statusBarView)

    loadPhotos { photos, error in
      if error == nil {
        self.photos = sorted(photos, {
          $0.dateTaken.compare($1.dateTaken) == NSComparisonResult.OrderedAscending
        })
        self.collectionView?.reloadData()
      }
    }
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoCellIdentifier, forIndexPath: indexPath) as PhotoCell
    let photo = photos[indexPath.row]
    if let path = photo.imagePath.relativePath {
      cell.photoImageView.setAsyncImageURL(path)
    }
    cell.dateLabel.text = dateFormatter.stringFromDate(photo.dateTaken)
    return cell
  }

  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier, forIndexPath: indexPath) as UICollectionReusableView
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let destination = PhotoDetailController()
    destination.photo = photos[indexPath.row]
    presentViewController(destination, animated: true, completion: nil)
  }

}
