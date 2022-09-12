import UIKit

public class FAPaginationLayout: UICollectionViewFlowLayout {

    //  Class properties

    var insertingTopCells: Bool = false
    var sizeForTopInsertions: CGSize = CGSize.zero

    //  Preparing the layout

    override public func prepare() {

        super.prepare()

        let oldSize: CGSize = sizeForTopInsertions

        if insertingTopCells {

            let newSize: CGSize  = collectionViewContentSize
            let xOffset: CGFloat = collectionView!.contentOffset.x + (newSize.width - oldSize.width)
            let newOffset: CGPoint = CGPoint(x: xOffset, y: collectionView!.contentOffset.y)
            collectionView!.contentOffset = newOffset
        } else {
            insertingTopCells = false
        }

        sizeForTopInsertions = collectionViewContentSize
    }
    //  configuring the content offsets relative to the scroll velocity
    //  Solution provided by orlandoamorim

    var lastPoint: CGPoint = CGPoint.zero

    //  configuring the content offsets relative to the scroll velocity
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let layoutAttributes: Array = layoutAttributesForElements(in: collectionView!.bounds)!

        if layoutAttributes.isEmpty {
            return proposedContentOffset
        }
        var targetIndex = layoutAttributes.count / 2

        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x

        if vX > 0 {
            targetIndex += 1
        } else if vX < 0.0 {
            targetIndex -= 1
        } else if vX == 0 {
            return lastPoint
        }

        if targetIndex >= layoutAttributes.count {
            targetIndex = layoutAttributes.count - 1
        }

        if targetIndex < 0 {
            targetIndex = 0
        }

        let targetAttribute = layoutAttributes[targetIndex]

        lastPoint = CGPoint(x: targetAttribute.center.x - collectionView!.bounds.size.width * 0.5, y: proposedContentOffset.y)
        return lastPoint
    }
}
