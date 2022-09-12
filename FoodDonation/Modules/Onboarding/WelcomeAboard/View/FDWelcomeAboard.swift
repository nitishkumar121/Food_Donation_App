//
//  welcomeAboard.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 26/05/22.
//

import UIKit

class FDWelcomeAboard: UIViewController {

    // MARK: - Outlets
    @IBOutlet private(set) weak var welcomeName : UILabel!

    // MARK: - Properties
    var name : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        guard let name = name else {return}
        welcomeName.text = name
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
}

    // MARK: - Go Button Action Method
    @IBAction private func goButtton( _sender : UIButton) {
        var vcArray = self.navigationController?.viewControllers
        vcArray!.removeAll()
        guard let vc = CommonFunction.commonFunction.instantiate(vc: ViewController.loginScreen.value, from: Storyboard.main.value) as? FDLoginVC else {return}
         vcArray?.append(vc)
        closureForLink?()
        self.navigationController?.setViewControllers(vcArray ?? [UIViewController()], animated: true)

    }
}
