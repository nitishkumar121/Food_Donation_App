//
//  FDHomeFoodDetail.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 22/06/22.
//

import UIKit

class FDHomeFoodDetail: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak private var foodDetailCollectionView : UICollectionView!
    @IBOutlet weak private var pageControl : UIPageControl!

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDetailCollectionView.register(UINib(nibName: ViewController.IdentifierName.detailsCollectionCell.value, bundle: nil), forCellWithReuseIdentifier: ViewController.IdentifierName.detailsCollectionCell.value)
        foodDetailCollectionView.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        foodDetailCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }

    // MARK: - Back Navigation Button Action
    @IBAction private func backButton() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension FDHomeFoodDetail : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = foodDetailCollectionView.dequeueReusableCell(withReuseIdentifier: ViewController.IdentifierName.detailsCollectionCell.value, for: indexPath) as? FoodDetailsCollectionCell else {return UICollectionViewCell()}
        cell.cellImage.layer.cornerRadius = 15
        cell.cellImage.layer.masksToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = collectionView.bounds.size
        cellSize.width -= collectionView.contentInset.left
        cellSize.width -= collectionView.contentInset.right
        cellSize.height = collectionView.frame.height
        return cellSize
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let xPoint = targetContentOffset.pointee.x
        pageControl.currentPage = Int(xPoint  / foodDetailCollectionView.frame.width)
    }
}
