//
//  FDOnboardingNavigationController.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 14/04/22.
//

import UIKit

class FDOnboardingNavigationController: UINavigationController {

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBarButton()
    }

    // MARK: - SetUp Bar Back Button
    func setUpBarButton() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: StringConstant.arrow.value), for: .normal)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = barButton
    }

    // MARK: - Back Button Tapped Action
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
