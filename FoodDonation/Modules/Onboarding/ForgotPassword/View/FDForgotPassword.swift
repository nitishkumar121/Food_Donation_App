//
//  FDForgotPassword.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 11/04/22.
//

import UIKit

class FDForgotPassword: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var email      : UITextField!
    @IBOutlet private weak var emailTitle : UILabel!
    @IBOutlet private weak var warningMsg : UILabel!
    @IBOutlet private weak var sendButton : UIButton!
    @IBOutlet private weak var forgotloader : UIActivityIndicatorView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBackButton()
    }

    // MARK: - Navigation Custom Back Button
    private func navigationBackButton() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: StringConstant.arrow.value), for: .normal)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = barButton
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Text Field Action
    @IBAction private func loginTextFieldsAction(_ sender: UITextField) {
        switch sender {

        case email :
            if email.text!.isEmpty {
                self.emailTitle.isHidden = true
            } else {
                self.emailTitle.isHidden = false
            }

        default : break
        }

        switch sender {

        case email :
            if email.text!.isEmpty {
                self.warningMsg.isHidden = true
            }

        default : break
        }
    }

    // MARK: - Send Button Action
    @IBAction private func sendButton(_ sender : UIButton) {
        forgotloader.startAnimating()
        let object = ForgotPasswordViewModel()
        object.credential.email = email.text
        object.apiCall()
        sentOtpMail = {
        guard let vc = CommonFunction.commonFunction.instantiate(vc: "otpScreen", from: Storyboard.main.value) as? FDOTPVC else {return}
            vc.enteredEmail = self.email.text
                    self.navigationController?.pushViewController(vc, animated: true)
            self.forgotloader.stopAnimating()
        }
    }
}

// MARK: - Extension TextField Delegate
extension FDForgotPassword : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.warningMsg.isHidden = true
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        switch textField {

        case email : if CommonFunction.commonFunction.isValidEmailAddress(emailAddressString: email.text!) || email.text!.isEmpty {
            self.warningMsg.isHidden = true
            self.sendButton.isUserInteractionEnabled = true
        } else {
            self.warningMsg.isHidden = false
            self.sendButton.isUserInteractionEnabled = false
        }

        default : break
        }
        return true
    }
}
