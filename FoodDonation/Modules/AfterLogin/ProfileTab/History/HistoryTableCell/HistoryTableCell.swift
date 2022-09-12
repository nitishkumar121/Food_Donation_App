//
//  HistoryTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 01/07/22.
//

import UIKit

class HistoryTableCell: UITableViewCell {
    @IBOutlet private weak var historyCellView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
    }
}
