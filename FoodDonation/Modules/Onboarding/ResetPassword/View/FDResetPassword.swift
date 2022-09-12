//
//  FDResetPassword.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 24/05/22.
//

import UIKit

var closure : ( () -> Void )?
var closureForLink : ( () -> Void )?

class FDResetPassword: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var newPassword          : UITextField!
    @IBOutlet private weak var newPasswordTitle     : UILabel!
    @IBOutlet private weak var confirmPassword      : UITextField!
    @IBOutlet private weak var confirmPasswordTitle : UILabel!
    @IBOutlet private weak var submitButton         : UIButton!
    @IBOutlet private weak var resetpasswordLoader  : UIActivityIndicatorView!

    // MARK: - Properties
    var showBtn = false
    var conShowBtn = false
    var email : String?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBackButton()
        self.showButton()
        self.confirmShowButton()

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
        closure = {   guard let vc = CommonFunction.commonFunction.instantiate(vc: "LoginScreen", from: Storyboard.main.value) as? FDLoginVC else {return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
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

        case newPassword :
            if newPassword.text!.isEmpty {
                self.newPasswordTitle.isHidden = true
            } else {
                self.newPasswordTitle.isHidden = false
            }

        case confirmPassword :
            if confirmPassword.text!.isEmpty {
                self.confirmPasswordTitle.isHidden = true
            } else {
                self.confirmPasswordTitle.isHidden = false
            }

        default : break
        }

        if newPassword.text!.isEmpty && confirmPassword.text!.isEmpty {
            submitButton.isUserInteractionEnabled = false
        } else {
            submitButton.isUserInteractionEnabled = true
        }
    }

    private func showButton( _ title : String = StringConstant.show.value) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.frame = view.frame
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        newPassword.rightView = button
        newPassword.rightViewMode = .always
        if title == StringConstant.show.value {
            button.setTitleColor(ColorAssest.textColor.color ,  for: .normal)
        } else {
            button.setTitleColor(ColorAssest.black.color ,  for: .normal)
        }
    }

    @objc func refresh(_ sender: Any) {
        showBtn.toggle()
        if showBtn {
            showButton(StringConstant.show.value)
            newPassword.isSecureTextEntry = true
        } else {
            showButton(StringConstant.hide.value)
            newPassword.isSecureTextEntry = false
        }
    }

    private func confirmShowButton( _ title : String = StringConstant.show.value) {

        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.frame = view.frame
        button.addTarget(self, action: #selector(self.confirmRefresh), for: .touchUpInside)
        confirmPassword.rightView = button
        confirmPassword.rightViewMode = .always
        if title == StringConstant.show.value {
            button.setTitleColor(ColorAssest.textColor.color ,  for: .normal)
        } else {
            button.setTitleColor(ColorAssest.black.color ,  for: .normal)
        }
    }

    @objc func confirmRefresh(_ sender: Any) {
        conShowBtn.toggle()
        if conShowBtn {
            confirmShowButton(StringConstant.show.value)
            confirmPassword.isSecureTextEntry = true
        } else {
            confirmShowButton(StringConstant.hide.value)
            confirmPassword.isSecureTextEntry = false
        }
    }

    // MARK: - Submit Button
    @IBAction private func resetPasswordSubmitButton(_ sender : UIButton) {
        if newPassword.text! == confirmPassword.text! {
            let instance = ResetPasswordViewModel()
            instance.credentials.email = email
            instance.credentials.password = confirmPassword.text
            resetpasswordLoader.startAnimating()
            instance.apiCall()
           } else {
            print(false)
               resetpasswordLoader.stopAnimating()
        }
        resetPasswordSuccessfully = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SuccessfullyPopUp")  else {return}
            self.present(controller, animated: true, completion: nil)
            self.resetpasswordLoader.stopAnimating()
        }
    }
}

// MARK: - Extension TextField Delegate
extension FDResetPassword : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case newPassword :
            newPassword.resignFirstResponder()
            confirmPassword.becomeFirstResponder()

        case confirmPassword :
            confirmPassword.resignFirstResponder()

        default:
            break
        }
        return true
    }
}
