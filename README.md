# instagarm-like (followers/following screen)
---------------------------------------------
The ios app demonstrates animated segmented buttons that are integrated with collectionView instagram-like followers/following screen.

![alt text](https://github.com/mdo91/instagarm-followers/blob/main/resources/md01.gif). 

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
   let segmentedButtonsView = SegmentedButtonsView()
    segmentedButtonsView.setLabelsTitles(titles: ["Followers", "Following"])
    return collectionViewHeader
}()
```
Please consider to call 'setLabelsTitles' method of 'SegmentedButtonsView' instance in order to set labels titles.
In your viewController make it conforms to 'SegmentedControlDelegate' in order to trigger selected button index:

```swift
extension MainViewController: SegmentedControlDelegate{

    //MARK: - segmented Control delegate
    
    func didIndexChanged(at index: Int) {

        if index == 0 {
        // do something
    
        }else if index == 1 {
        //do something

        }
    }
}
```

If you're willing to use segmentedViewButtons to be integrated with a collection view with more than 2 buttons, you can replace the code inside the 'collectionViewDidScroll' delegate function of 'SegmentedButtonsView.swift' :

```swift
if  (label.frame.width / 2  >= self.selectorView.frame.origin.x && titles[0] == label.text! ||
     label.frame.width / 2  <= self.selectorView.frame.origin.x && titles[1] == label.text! ) {
                            
      label.textColor = selectorTextColor
                            
    }else{

        label.textColor = textColor
}

```
with the following code that supports more than two buttons(labeLs) view:

```swift
if label.frame.origin.x == self.selectorView.frame.origin.x{
    label.textColor = selectorTextColor
}else{
    label.textColor = textColor
}
```





