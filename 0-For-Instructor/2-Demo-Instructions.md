# 308: Collection View Custom Layouts: Demo Instructions

In this demo, you’ll build a basic custom layout that displays the sessions of a conference schedule.

The steps here will be explained in the demo, but here are the raw steps in case you miss a step or get stuck.

### 1) Create Layout

Right-click on the **Layouts** group, and from the menu choose **New File...**. Then, select **iOS\Source\Swift File** and click **Next**. Name the file **ScheduleLayout.swift** and click **Create**. 

Open the file **ScheduleLayout.swift**, and at the top import UIKit:

	import UIKit

Then add the class definition, making sure to subclass UICollectionViewLayout:

	class ScheduleLayout: UICollectionViewLayout {
	}

Save your changes.

### 2) Update Storyboard

Open **main.storyboard**. In the Document Inspector, expand **Schedule Scene** until you find the collection view. Select the collection view, and then in the Attributes Inspector change the **Layout** to **Custom** and set the **Class** to **Schedule Layout**.

Save your changes.

### 3) Add Data Source

Drag an **Object** from the Object Library onto the **Schedule Scene** in the Document Outline. Select the object, and in the Identity Inspector change its **Custom Class** to **ScheduleDataSource**.

In the Document Outline, right-click on the collection view to bring up its outlets. Click the small ‘x’ to disconnect the existing dataSource outlet, and then drag from the **dataSource** outlet to the **ScheduleDataSource** object to connect them.

### 4) Setup Properties

Open **ScheduleLayout.swift** and add the following private property to the top of the class:

	private lazy var dataSource: ScheduleDataSource = {
	  return self.collectionView!.dataSource as ScheduleDataSource
	}()

Save your changes.

### 5) Calculate Frame

Add the `frameForSession(_: atIndexPath:)` method just below the property:

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

Save your changes.

It’s now time to override the four methods required to implement a custom layout.

### 6) Determine Content Size

First, override `collectionViewContentSize()`. Place this just below `frameForSession(_: atIndexPath:)`:

	override func collectionViewContentSize() -> CGSize {
	  let hoursInSchedule = CGFloat(dataSource.numberOfHoursInSchedule)
	  let height = CGRectGetHeight(collectionView!.bounds) - collectionView!.contentInset.top
	  let width = hoursInSchedule * dataSource.widthPerHour
	  return CGSizeMake(width, height)
	}

Save your changes.

### 7) Layout Attributes For Elements

Next, override `layoutAttributesForElementsInRect(_:)`. Add the following to `ScheduleLayout`:

	override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
	  let attributes = NSMutableArray()
	  let itemIndexPaths = dataSource.indexPathsOfScheduleItems()
	  for indexPath in itemIndexPaths {
	    let itemAttributes = layoutAttributesForItemAtIndexPath(indexPath as NSIndexPath)
	    attributes.addObject(itemAttributes)
	  }
	  return attributes
	}

Check out the slides for an overview of what this method is for, and why it’s so important.

Save your changes.

### 8) Layout Attributes For Each Item

Then, override `layoutAttributesForItemAtIndexPath(_:)` by adding the following just below the method you added in the previous step:

	override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
	  let session = dataSource.sessionForIndexPath(indexPath)
	  let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
	  attributes.frame = frameForSession(session, atIndexPath: indexPath)
	  return attributes
	}

Save your changes.

### 9) Invalidating The Layout

Finally, override `shouldInvalidateLayoutForBoundsChange(_:)` and return `true`. Add the following:

	override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
	  return true
	}

Save your changes.

### 10) Add Session Titles

Open **ScheduleViewController.swift** and override `viewDidLoad()`, making sure to also call `super`. Add the following to the top of the class:

	override func viewDidLoad() {
	  super.viewDidLoad()
	
	}

Then, add the following just below the call to `super`:

	let dataSource = collectionView!.dataSource as ScheduleDataSource

And finally, pass a cell configuration block to the data source that sets the cell’s `nameLabel` to the session title. Add the following to the bottom of `viewDidLoad()`:

	dataSource.cellConfigurationBlock = {(cell: ScheduleCell, indexPath: NSIndexPath, session: NSDictionary) in
	  cell.nameLabel.text = session["Name"] as NSString
	}

Save you changes. Build and run :]

### 11) That’s it!

Congratulations! At this point you should have a basic custom layout up and running that displays the sessions of the conference schedule.

You’re now ready to move onto the lab.