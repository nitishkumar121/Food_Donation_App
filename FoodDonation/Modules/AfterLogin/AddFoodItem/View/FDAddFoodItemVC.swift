//
//  FDAddFoodItemVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 03/06/22.
//

import UIKit
import AssetsPickerViewController
import Photos
class FDAddFoodItemVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var addItemCollectionView        : UICollectionView!
    @IBOutlet private weak var selectCategoryCollectionView : UICollectionView!
    @IBOutlet private weak var titleLabel                   : UILabel!
    @IBOutlet private weak var descriptionLabel             : UILabel!
    @IBOutlet private weak var titleField                   : UITextField!
    @IBOutlet private weak var descriptionField             : UITextField!
    @IBOutlet private weak var galleryOpenImageView         : UIImageView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var selectCategoryStackView      : UIStackView!
    @IBOutlet private weak var foodQuantity                 : UILabel!
    @IBOutlet private weak var foodDay                      : UILabel!

    var selectedImage = [PHAsset]()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nibLoadCollectionCell()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(galleryOpen))
        let selectCategoryTapGesture = UITapGestureRecognizer()
        selectCategoryTapGesture.addTarget(self, action: #selector(selectCategory))
        galleryOpenImageView.isUserInteractionEnabled = true
        selectCategoryStackView.isUserInteractionEnabled = true
        galleryOpenImageView.addGestureRecognizer(tapGesture)
        selectCategoryStackView.addGestureRecognizer(selectCategoryTapGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeightConstraint.constant = selectCategoryCollectionView.collectionViewLayout.collectionViewContentSize.height
            view.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        selectCategoryCollectionView.reloadData()
        print("selected catagrory : - ",Category.shared.selectedCategory())
    }

    private func nibLoadCollectionCell() {
        let nib = UINib(nibName: "AddItemCollectionCell", bundle: nil)
        addItemCollectionView.register(nib, forCellWithReuseIdentifier: "AddItemCollectionCell")
        let nib2 = UINib(nibName: "SelectCategoryCell", bundle: nil)
        selectCategoryCollectionView.register(nib2, forCellWithReuseIdentifier: "SelectCategoryCell")
    }

    // MARK: - Food Image Upload From Photo Library Button
    @objc private func galleryOpen() {
        let pickerConfig = AssetsPickerConfig()
        pickerConfig.albumIsShowHiddenAlbum = true
        pickerConfig.selectedAssets = self.selectedImage
        let picker = AssetsPickerViewController()
        picker.pickerConfig = pickerConfig
        picker.pickerDelegate = self
        pickerConfig.assetsMaximumSelectionCount = 4
        present(picker, animated: true, completion: nil)
}

    // MARK: - Select Category Button
    @objc func selectCategory() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: "FDSelectCategoryVC", from: "AddFoodTab"), animated: true)
    }

    // MARK: - Change Button Acction
    @IBAction private func selectFoodQuantityChangedButton(_ sender : UIButton!) {
        let storyboard = UIStoryboard(name: "AddFoodTab", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectFoodQuantityVC")
        self.present(controller, animated: true, completion: nil)
        enterFoodQuantity = { foodQuantity in
            print("Food Quantity : - \(foodQuantity)")
            setFoodQuantity = {
                print("Food Quantity Again : - \(foodQuantity)")
                self.foodQuantity.text = "For \(foodQuantity) Person"
            }
        }
    }

    @IBAction private func selectExpiryChangedButton() {
        let storyboard = UIStoryboard(name: "AddFoodTab", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectFoodExpiryDayPopUpVC")
        self.present(controller, animated: true, completion: nil)
        enterDay = { day in
            print("Food Day : - \(day)")
            setFoodDay = {
                print("Food Day Again : - \(day)")
                self.foodDay.text = "List Of \(day) Day"
            }
        }
    }

    // MARK: - TextField Action
   @IBAction private func textFieldsAction(_ sender: UITextField) {
        switch sender {

        case titleField :
            if titleField.text!.isEmpty {
                self.titleLabel.isHidden = true
            } else {
                self.titleLabel.isHidden = false
            }

        case descriptionField : if descriptionField.text!.isEmpty {
            self.descriptionLabel.isHidden = true
        } else {
            self.descriptionLabel.isHidden = false
        }

        default : break
        }
    }
}

extension FDAddFoodItemVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case addItemCollectionView :
            return selectedImage.count
        case selectCategoryCollectionView :
            return Category.shared.selectedCategory().count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case addItemCollectionView :
        guard let cell = addItemCollectionView.dequeueReusableCell(withReuseIdentifier: "AddItemCollectionCell", for: indexPath) as? AddItemCollectionCell else {return UICollectionViewCell()}
            if selectedImage.isEmpty {
                addItemCollectionView.isHidden = true
                return cell
            } else {
                addItemCollectionView.isHidden = false
              cell.addImage.image = getAssetThumbnail(asset: selectedImage[indexPath.row])
                cell.deleteButton.layer.setValue(indexPath.row, forKey: "index")
                cell.deleteButton.addTarget(self, action: #selector(self.deleteImageButton(_:)), for: .touchUpInside)
                return cell
            }
        case selectCategoryCollectionView :
            guard let cell = selectCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectCategoryCell", for: indexPath) as? SelectCategoryCell else {return UICollectionViewCell()}
            cell.selectCategoryName.text = Category.shared.selectedCategory()[indexPath.item]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    @objc func deleteImageButton(_ sender : UIButton) {
        guard let index : Int = (sender.layer.value(forKey: "index")) as? Int else {return}
        selectedImage.remove(at: index)
        addItemCollectionView.reloadData()
        if selectedImage.isEmpty {
            addItemCollectionView.isHidden = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case addItemCollectionView :
        let yourWidth = collectionView.frame.width/4
        let yourHeight = yourWidth

            return CGSize(width: yourWidth - 10, height: yourHeight)
        case selectCategoryCollectionView :

            return CGSize(width: 0 , height: 35)
        default:
            return CGSize()
        }
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: option, resultHandler: {(result,_ info) -> Void in
                thumbnail = result!
        })
        return thumbnail
    }

}

extension FDAddFoodItemVC : AssetsPickerViewControllerDelegate {

    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        selectedImage = assets
        addItemCollectionView.reloadData()
    }

    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}

    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        if controller.selectedAssets.isEmpty {
            controller.photoViewController.deselectAll()
        }
        return true
    }

}
