//
//  JoinUsTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 14/07/22.
//

import UIKit

class JoinUsTableCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private(set) weak var joinUsImage : UIImageView!
    @IBOutlet private(set) weak var joinUsIconImage : UIImageView!
    @IBOutlet private(set) weak var joinUsTitleName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        joinUsImage.image = UIImage()
        joinUsIconImage.image = UIImage()
        joinUsTitleName.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        joinUsImage.layer.applySketchShadow(color: ColorAssest.shadowsColor.color, alpha: 0.08, _x: 0, _y: 3, blur: 10, spread: 0)
    }
}
