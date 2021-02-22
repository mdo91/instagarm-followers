import UIKit
protocol CollectionViewDidScrollDelegate:class {
    func collectionViewDidScroll(for x: CGFloat)
    
}
protocol SegmentedControlDelegate:class{
    func didIndexChanged(at index: Int)
}

