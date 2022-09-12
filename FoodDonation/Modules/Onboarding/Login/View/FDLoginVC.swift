import UIKit
import FBSDKLoginKit

class FDLoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var password      : UITextField!
    @IBOutlet private weak var email         : UITextField!
    @IBOutlet private weak var emailTitle    : UILabel!
    @IBOutlet private weak var passwordTitle : UILabel!
    @IBOutlet private weak var emailWarning  : UILabel!
    @IBOutlet private weak var loaderView    : UIActivityIndicatorView!

    // MARK: - Properties
    var showBtn = false

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showButton()
        self.navigationBackButton()
    }
    // MARK: - Navigation Custom Back Button
    private func navigationBackButton() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        closureForLink = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: ViewController.IdentifierName.emailVerify.value)  else {return}
            self.present(controller, animated: true, completion: nil)
        }
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

    // MARK: - Login Button
    @IBAction private func loginBtn(_ sender: UIButton) {
        guard let email = email.text, let password = password.text else {
            return
        }
        loaderView.isHidden = false
        loaderView.startAnimating()
        let loginViewModel = FDLoginViewModel()
        loginViewModel.credentials.email = email
        loginViewModel.credentials.password = password
        loginViewModel.apiCall()
        loginSucces = { token in
             UserDefault.shared.saveData(token, key: "token")
            self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.tabBarVC.value, from: Storyboard.map.value), animated: true)
            self.loaderView.stopAnimating()
            self.loaderView.isHidden = true
        }
        loginFail = { msg in
          print(msg)
            self.loaderView.stopAnimating()
            self.loaderView.isHidden = true
        }
    }

    // MARK: - Sign Up Button
    @IBAction private func signUpButton(_ sender : UIButton) {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.signupVC.value, from: Storyboard.main.value), animated: true)
    }

    // MARK: - Forgot Password Button Action
    @IBAction private func forgotPasswordButton(_ sender : UIButton) {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.forgotPassword.value, from: Storyboard.main.value), animated: true)
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

        case password : if password.text!.isEmpty {
            self.passwordTitle.isHidden = true
        } else {
            self.passwordTitle.isHidden = false
        }

        default : break
        }

        switch sender {

        case email :
            if email.text!.isEmpty {
                self.emailWarning.isHidden = true
            }

        default : break
        }
    }

    private func showButton( _ title : String = StringConstant.show.value) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(ColorAssest.textColor.color ,  for: .normal)
        button.frame = view.frame
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        password.rightView = button
        password.rightViewMode = .always
    }

    @objc func refresh(_ sender: Any) {
        showBtn.toggle()
        if showBtn {
            showButton(StringConstant.show.value)
            password.isSecureTextEntry = true
        } else {
            showButton(StringConstant.hide.value)
            password.isSecureTextEntry = false
        }
    }
}

// MARK: - Extension TextField Delegate
extension FDLoginVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case email :
            email.resignFirstResponder()
            password.becomeFirstResponder()

        case password :
            password.resignFirstResponder()

        default:
            break
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.emailWarning.isHidden = true
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        switch textField {

        case email : if CommonFunction.commonFunction.isValidEmailAddress(emailAddressString: email.text!) || email.text!.isEmpty {
            self.emailWarning.isHidden = true
        } else {
            self.emailWarning.isHidden = false
        }

        default : break
        }
        return true
    }
}
