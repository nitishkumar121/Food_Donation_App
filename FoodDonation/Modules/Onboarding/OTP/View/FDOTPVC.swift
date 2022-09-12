import UIKit

class FDOTPVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var otp1 : UITextField!
    @IBOutlet private weak var otp2 : UITextField!
    @IBOutlet private weak var otp3 : UITextField!
    @IBOutlet private weak var otp4 : UITextField!
    @IBOutlet private weak var otpTimer : UILabel!
    @IBOutlet private weak var email : UILabel!
    @IBOutlet private weak var resendOtp : UIButton!
    @IBOutlet private weak var verifyOtpBtn : UIButton!
    @IBOutlet private weak var otpLoader : UIActivityIndicatorView!

    // MARK: - Properties
    let instance = OTPViewModel()
    var enteredEmail : String?
    var seconds = 60
    var timer = Timer()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldBorderColor()
        self.setTextFieldDelegateAndAction()
        self.runTimer()
        self.otpSendEmail()
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

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        seconds -= 1
        if seconds >= 10 {
            let myString = NSMutableAttributedString(string: "OTP expires in 00:\(seconds)")
            let myRange = NSRange(location: 15, length: 5)
            myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: myRange)
            otpTimer.attributedText = myString
        } else if seconds >= 0 {
            let myString = NSMutableAttributedString(string: "OTP expires in 00:0\(seconds)")
            let myRange = NSRange(location: 15, length: 5)
            myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: myRange)
            otpTimer.attributedText = myString
        } else {
            stopTimerTest()
            resendOtp.isHidden = false
            otpTimer.isHidden = true
        }
    }

    // MARK: - Stop OTP Timer Method
    func stopTimerTest() {
        timer.invalidate()
    }

    // MARK: - set TextField BorderColor
    private func textFieldBorderColor() {
        self.otp1.layer.borderColor = ColorAssest.textColor.color.cgColor
        self.otp2.layer.borderColor = ColorAssest.textColor.color.cgColor
        self.otp3.layer.borderColor = ColorAssest.textColor.color.cgColor
        self.otp4.layer.borderColor = ColorAssest.textColor.color.cgColor
    }

    // MARK: - Set Textfield Delegate and Action
    private func setTextFieldDelegateAndAction() {
        self.otp1.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otp2.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otp3.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.otp4.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
    }

    // MARK: - OTP TextField Responder Function
    @objc private func changeCharacter(textField : UITextField) {
        if textField.text?.utf8.count == 1 {
            switch textField {
            case otp1:
                otp2.becomeFirstResponder()
            case otp2:
                otp3.becomeFirstResponder()
            case otp3:
                otp4.becomeFirstResponder()
            case otp4:
                otp4.resignFirstResponder()
            default:
                break
            }
        } else if textField.text!.isEmpty {
            switch textField {
            case otp4:
                otp3.becomeFirstResponder()
            case otp3:
                otp2.becomeFirstResponder()
            case otp2:
                otp1.becomeFirstResponder()
            default:
                break
            }
        }
    }

    private func otpSendEmail() {
        let myString = NSMutableAttributedString(string: "The validation code received via Email on \(enteredEmail!)")
        let myRange = NSRange(location: 42, length: myString.length - 42)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 11), range: myRange)
        email.attributedText = myString
    }
    // MARK: - Resend OTP Button Action
    @IBAction private func resendOtpButton(_ sender : UIButton) {
        instance.obj.email = enteredEmail
        instance.apiCallOtpSend()
        resendOtp.isHidden = true
        seconds = 60
        runTimer()
        otpTimer.isHidden = false
    }

    // MARK: - Verify OTP Button Action
    @IBAction private func verifyOtpButton(_ sender : UIButton) {
        guard let otp1 = otp1.text , let otp2 = otp2.text  , let otp3 = otp3.text , let otp4 = otp4.text else {return}
        instance.credentials.email = enteredEmail
        instance.credentials.otp = (otp1 + otp2 + otp3 + otp4)
        otpLoader.startAnimating()
        instance.apiCallForverifyOtpMail()
        verifyOtp = {
            guard let vc = CommonFunction.commonFunction.instantiate(vc: "ResetPasswordScreen", from: Storyboard.main.value) as? FDResetPassword else {return}
            vc.email = self.enteredEmail
                        self.navigationController?.pushViewController(vc, animated: true)
            self.otpLoader.startAnimating()
            }
        }
}
// MARK: - Extension UITextField

extension FDOTPVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let accept : Bool
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        accept = string == numberFiltered
        let maxLength = 1
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength && accept
    }
}
