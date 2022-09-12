//
//  ContributorTableCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 15/07/22.
//

import UIKit

class ContributorTableCell: UITableViewCell {
    @IBOutlet private weak var contributorCollectionView : UICollectionView!
    @IBOutlet private(set) weak var separatorView : UIView!
    @IBOutlet private(set) weak var contributorTitle : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contributorCollectionView.delegate = self
        contributorCollectionView.dataSource = self
        contributorCollectionView.register(UINib(nibName: "ContributorCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ContributorCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        separatorView.isHidden = false
    }
}

extension ContributorTableCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contributorCollectionView.dequeueReusableCell(withReuseIdentifier: "ContributorCollectionCell", for: indexPath) as? ContributorCollectionCell else {return UICollectionViewCell() }
        return cell
    }
}

extension ContributorTableCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4 - 10, height: collectionView.frame.height)
    }
}
