//
//  ClaimsTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 08/07/22.
//

import UIKit

class ClaimsTableCell: UITableViewCell {
    @IBOutlet private(set) weak var progressView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.progressView.isHidden = false
    }
}
