//
//  HomeTabCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 31/05/22.
//

import UIKit

class HomeTabCell: UICollectionViewCell {

    @IBOutlet private weak var view : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
           // cell rounded section
           self.view.cornerRadius = 10
           self.layer.applySketchShadow()
    }

}
