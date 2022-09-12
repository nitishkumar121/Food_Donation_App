//
//  AddItemCollectionCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 03/06/22.
//

import UIKit

class AddItemCollectionCell: UICollectionViewCell {
    @IBOutlet private(set) weak var addImage : UIImageView!
    @IBOutlet private(set) weak var deleteButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
