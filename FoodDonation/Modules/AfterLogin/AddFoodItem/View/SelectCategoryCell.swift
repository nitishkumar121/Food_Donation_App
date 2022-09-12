//
//  SelectCategoryCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 03/06/22.
//

import UIKit

class SelectCategoryCell: UICollectionViewCell {

    // MARK: - Outlet
    @IBOutlet private(set) weak var selectCategoryName : UILabel!
    @IBOutlet private(set) weak var deleteButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
