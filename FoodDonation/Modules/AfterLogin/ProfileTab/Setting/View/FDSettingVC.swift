//
//  FDSettingVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 02/06/22.
//

import UIKit

class FDSettingVC: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Back Bar Button Action
    @IBAction private func backBarButton() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func signOutButton() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignOutPopVC")  else {return}
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction private func switchBtn(_ sender: UIButton) {
        if !sender.isSelected {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                sender.isSelected = true
            }
        } else {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                sender.isSelected = false
            }
        }
    }
    
}
