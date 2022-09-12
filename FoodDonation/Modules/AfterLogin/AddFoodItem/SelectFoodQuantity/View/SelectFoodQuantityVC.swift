//
//  SelectFoodQuantityVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 29/06/22.
//

import UIKit

class SelectFoodQuantityVC: UIViewController {

    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Text Field Action
    @IBAction private func textFieldAction(_ foodQuantity : UITextField!) {
        guard let foodQuantity = foodQuantity.text else { return }
        let instance = SelectFoodQuantityViewModel()
        instance.foodQuantity = foodQuantity
    }

    // MARK: - SubmitButton Action
    @IBAction private func submitButton(_ sender : UIButton) {
        self.view.endEditing(true)
        setFoodQuantity?()
        self.dismiss(animated: true)
    }
}
