//
//  FDSuccessfullyPopUpAlert.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 27/05/22.
//

import UIKit

class FDSuccessfullyPopUpAlert: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Ok Button Action
    @IBAction private func okButton(_ sender : UIButton) {
        dismiss(animated: true, completion: nil)
        closure?()
    }
}
