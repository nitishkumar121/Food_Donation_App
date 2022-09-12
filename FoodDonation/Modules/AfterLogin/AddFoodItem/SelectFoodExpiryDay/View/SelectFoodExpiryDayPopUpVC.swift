//
//  SelectFoodExpiryDayVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 29/06/22.
//

import UIKit

class SelectFoodExpiryDayPopUpVC : UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Text Field Action
    @IBAction private func textFieldAction(_ foodDay : UITextField!) {
        guard let foodDay = foodDay.text else { return }
        let instance = SelectFoodExpiryDayViewModel()
        instance.foodDay = foodDay
    }

    // MARK: - SubmitButton Action
    @IBAction private func submitButton(_ sender : UIButton) {
        self.view.endEditing(true)
        setFoodDay?()
        self.dismiss(animated: true)
    }
}
