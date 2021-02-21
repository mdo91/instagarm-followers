# instagarm-like (followers/following screen)
---------------------------------------------
The ios app demonstrates animated segmented buttons that are integrated with collectionView instagram-like followers/following screen.

![alt text](https://github.com/mdo91/instagarm-followers/blob/main/resources/insta.gif). 

### usage:

The app is created programmatically using UIKit with no storyboards. However, if you are using storyboards in your project:

1. Import 'SegmentedButtonsViewdrop.swift' file into your project.
2. Drop a UIView in your UIViewController.
3. Select the UIView, then in the identity inspector write in the custom class textfield 'SegmentedButtonsView' then hit enter.

For the functionality that is demonstrated above, there are two main classes: 

  SegmentedButtonsView and MainViewController.

  for instance in the code below:

```swift
lazy var segmentedButtonsView:SegmentedButtonsView = {
   let collectionViewHeader = SegmentedButtonsView()
    collectionViewHeader.setLablesTitles(titles: ["Followers", "Following"])
    return collectionViewHeader
}()
```
Please consider to call 'setLablesTitles' method of 'SegmentedButtonsView' instance in order to set lables titles.
In your viewController make it conforms to 'SegmentedControlDelegate' in order to trigger selected button index:

```swift
extension MainViewController: SegmentedControlDelegate{

    //MARK: - segmented Controller delegate
    
    func didIndexChanged(at index: Int) {

       
        if index == 0 {
        // do something
    
        }else if index == 1 {
        //do something

        }
    }
   
}
```


