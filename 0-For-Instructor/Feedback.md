
### Project
1. Use constructors on `CGSize` and `CGRect`
2. Move `session` into a model class
3. Return typed Swift arrays from the data source
4. Move layout-related constants from data source to layout
5. Prepare content of layout and add proper implementation of `attributesForElementsInRect(_:)`. Determine frames using `frameForSession(_:indexPath:)` and then test with `CGRectIntersect`

### Overview
1. Add some text to the cells
2. Add some properties to the layout attributes
3. Add a slide that shows the four required methods
4. Mention the reasons why we’re focusing just on `UICollectionViewLayout`

### Demo
1. Start with a Build & Run to provide some context
2. Tour the starter project:
	1. Storyboard
	2. Data source
	3. Plist file
	4. View controller
3. Slide for `frameForSession(_:indexPath:)`
4. Explain methods _after_ adding them, not before

### Lab
No changes required

### Challenge
1. Delete the three bullet points, leaving the reader to figure things out for themselves

### Conclusion
1. Pick a single, good quality example from GitHub

### Questions
1. Can you create a reusable view in a Storyboard?
2. Why do supplementary views have an index path?

