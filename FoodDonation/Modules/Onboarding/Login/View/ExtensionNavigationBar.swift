//
//  ExtensionNavigationBar.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 24/06/22.
//

import Foundation
import UIKit

extension UINavigationController {
    // MARK: - Navigation Custom Back Button
       func navigationBackButton() {
           self.navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: StringConstant.arrow.value), for: .normal)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = barButton
        closureForLink = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: ViewController.IdentifierName.emailVerify.value)  else {return}
            self.present(controller, animated: true, completion: nil)
        }
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
