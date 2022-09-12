//
//  SelectCategoryTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 23/06/22.
//

import UIKit
var categorySelect : ( (_ index : Int) -> Void)?
class SelectCategoryTableCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet private(set) weak var categoryName : UILabel!
    @IBOutlet private(set) weak var categorySelectCheckImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        categoryName.text = ""
        categorySelectCheckImage.image =  UIImage(named: "icUnselectedTick")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
