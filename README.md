# instagarm-like (followers/following screen)
---------------------------------------------
The ios app demonstrates animated segmented buttons that are integrated with collectionView instagram-like followers/following screen.

![alt text](https://github.com/mdo91/instagarm-followers/blob/main/resources/insta.gif). 

### usage:

The app is created using UIKit with no storyboards. However, if you are using storyboards in your project, drop a UIView in your UIViewController, select the UIView, then in the identity inspector write in the custom class textfield 'SegmentedButtonsView' then hit enter.

for the functionality that is demonstrated above, there are two main classes: SegmentedButtonsView and MainViewController.

for instatnce in the code below:

```swift
    lazy var segmentedButtonsView:SegmentedButtonsView = {
       let collectionViewHeader = SegmentedButtonsView()
        collectionViewHeader.setLablesTitles(titles: ["Followers", "Following"])
        return collectionViewHeader
    }()
```

