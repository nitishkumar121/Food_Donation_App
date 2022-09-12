//
//  ActivitiesClaimsTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 15/06/22.
//

import UIKit
var imageChange : (() -> Void )?
var image2Change : (() -> Void )?
class ActivitiesClaimsTableCell: UITableViewCell {
    @IBOutlet private(set) weak var cellImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
