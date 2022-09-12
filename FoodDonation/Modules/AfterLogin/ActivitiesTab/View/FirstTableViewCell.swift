//
//  FirstTableViewCell.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 06/07/22.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet private weak var activityCollectionView : UICollectionView!
    @IBOutlet private weak var detailView : UIView!
    @IBOutlet private(set) weak var mapButton : UIButton!
    @IBOutlet private(set) weak var pageControl : UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.applySketchShadow(color: ColorAssest.shadowsColor.color, alpha: 0.08, _x: 0, _y: 3, blur: 10, spread: 0)
        activityCollectionView.register(UINib(nibName: "ActivityCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

}
    override func prepareForReuse() {
        self.mapButton.isHidden = false
        self.pageControl.currentPage = 0
        self.activityCollectionView.reloadData()
    }
}

extension FirstTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = activityCollectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionCell", for: indexPath) as? ActivityCollectionCell else {return UICollectionViewCell()}
        return cell
    }

     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let xPosition = targetContentOffset.pointee.x
        pageControl.currentPage = Int(xPosition / activityCollectionView.frame.width)

    }

}

extension FirstTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
