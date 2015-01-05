# 305: View Controller Transitions

In this demo, you’ll build a slick custom view controller transition for your new .

The steps here will be explained in the demo, but here are the raw steps in case you miss a step or get stuck.

### Intro to the Project

Take a quick second to get used to the project that you are going to be working on so that you know how to get around. 

**Build and run** the starter project. Tap on any of the images that pops up. You should see a really simple modal controller transition and animation that you have probably seen thousands of times.

This transition uses the `modalPresentationStyle` of `.OverFullScreen` so that we can use a transparent background and see the previous controller behind it.

The code that presents the controller is at the bottom of **PhotosController.swift** in **collectionView:didSelectItemAtIndexPath:**.

### Create Layout

Right-click on the **Animation Coordinators** group, and from the menu choose **New File...**. Then, select **iOS\Source\Swift File** and click **Next**. Name the file **FullscreenPresentationDelegate.swift** and click **Create**. 

Open the file **FullscreenPresentationDelegate.swift**, and at the top import UIKit:

	import UIKit

Then add the class definition, subclassing `NSObject` and conforming to the protocol `UIViewControllerTransitioningDelegate`:

	class FullscreenPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
	}

Save your changes.

### Create Animators

Just like you created the file *FullscreenPresentationDelegate.swift*, right-click the **Animation Coordinators** group and create two more swift files: **FullscreenPresentationAnimator.swift** and **FullscreenPresentationDelegate.swift**.

Open the file **FullscreenPresentationAnimator.swift**, and at the top import UIKit:

	import UIKit

Then add the class definition, subclassing `NSObject` and conforming to the protocol `UIViewControllerAnimatedTransitioning`:

	class FullscreenDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	}

Try building the project. Notice that Xcode throws a compile error at you. This is because you need to finish conforming your new `FullscreenPresentationAnimator` class to the `UIViewControllerAnimatedTransitioning` protocol.

In the file **FullscreenPresentationAnimator.swift**, add the following two methods to your class definition:

	func transitionDuration(ctx: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 0.4
	}

	func animateTransition(ctx: UIViewControllerContextTransitioning) {}

Build your project to save it and see that it compiles. You will come back to this class later to create an animation.

**Copy** your entire **FullscreenPresentationAnimator.swift** file. Open **FullscreenDismissAnimator.swift**, highlight the entire file, and **paste**.

In **FullscreenDismissAnimator.swift**, change the FullscreenPresentationAnimator class to **FullscreenDismissAnimator**.

### Assigning Animators

Go back to **FullscreenPresentationDelegate.swift** and add a method to return objects that should be used for presentation and dismiss animations. You should be able to figure out which classes we are going to use.

	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return FullscreenDismissAnimator()
	}

	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return FullscreenPresentationAnimator()
	}

Build to save and make sure that your project compiles correctly.

### Wiring the Delegate

In order to use the transition delegate, you need both a strong reference to it, and need to assign the delegate to the controller being transitioned.

Open **PhotosController.swift** and add a new variable near the top of the class, near the other variables.

	let presentationDelegate = FullscreenPresentationDelegate()

Find the method **collectionView:didSelectItemAtIndexPath:** and before `presentViewController` is called, assign the transition delegate and make your presentation style custom:

	destination.modalPresentationStyle = .Custom
	destination.transitioningDelegate = presentationDelegate

Build to save and make sure that your project compiles correctly.

### Preparing to Animate

Open **FullscreenPresentationAnimator.swift** and find the method **animateTransition:**. The `UIViewControllerContextTransitioning` parameter contains a lot of information about the configuration and state of your transition.

In **animateTransition:**, get the following properties:

	let to = ctx.viewControllerForKey(UITransitionContextToViewControllerKey)! as PhotoDetailController
    let from = ctx.viewControllerForKey(UITransitionContextFromViewControllerKey)! as PhotosController
    let container = ctx.containerView()
    let duration = transitionDuration(ctx)

Now that you have your properties, add the *to* view to the scene so that we will see it when we animate.

	container.addSubview(to.view)

### Making it animate

Set an initial transform for the *to* view.

	to.view.transform = CGAffineTransformMakeScale(0.1, 0.1)

Then add a simple animation that removes the transform from the view.

	UIView.animateWithDuration(duration, animations: {
		to.view.transform = CGAffineTransformIdentity
	}) { finished in
		ctx.completeTransition(!ctx.transitionWasCancelled())
	}

Note the callback and call to `completeTransition:` and `transitionWasCancelled`.

`completeTransition:` *must* be called when you are finished with your custom animation. This tells the view controller system that the animation is done and it can go on its merry way.

`transitionWasCancelled` is a convenience method that will tell you if something has interrupted your transition or not. Usually with simple transitions like this you don't need to use it, but it's a good practice because you will need to use it once you get to interactive transitions.

Also, note that usually we would call `from.view.removeFromSuperview()` to clear it from the container, but since we are using a transparent background we want to leave it in the scene.

Build and run your app to see it work!

Wait a second, why can't you interact anymore?

### Adding a Dismiss

The view controller transitioning API doesn't play nicely when you don't follow the rules. The problem here is that your dismisser never calls `completeTransition:`.

Open **FullscreenDismissAnimator.swift** and find the **animateTransition:** method. Add a call to complete the transition.

	ctx.completeTransition(true)

This wont make a very pretty animation, but at least it works.

Build and run to see it in action.

### 11) That’s it!

Congratulations! At this point you should have a simple view controller animation between the list and detail views.

You’re now ready to move onto the lab.