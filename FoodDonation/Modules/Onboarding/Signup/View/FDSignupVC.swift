import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

class FDSignupVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var termAndConditionTextView     : UITextView!
    @IBOutlet private weak var signupButton                 : UIButton!
    @IBOutlet private weak var email                        : UITextField!
    @IBOutlet private weak var password                     : UITextField!
    @IBOutlet private weak var mobileNumber                 : UITextField!
    @IBOutlet private weak var fullName                     : UITextField!
    @IBOutlet private weak var signUpImage                  : UIImageView!
    @IBOutlet private weak var fullNameTitle                : UILabel!
    @IBOutlet private weak var mobileNumberTitle            : UILabel!
    @IBOutlet private weak var emailTitle                   : UILabel!
    @IBOutlet private weak var passwordTitle                : UILabel!
    @IBOutlet private weak var fullNameWarningMessage       : UILabel!
    @IBOutlet private weak var mobileNumberWarningMessage   : UILabel!
    @IBOutlet private weak var emailWarningMessage          : UILabel!
    @IBOutlet private weak var scrollView                   : UIScrollView!
    @IBOutlet private weak var countryCodeBtn               : UIButton!
    @IBOutlet private weak var cameraButton                 : UIButton!
    @IBOutlet private weak var passwordWarningMessage       : UILabel!
    @IBOutlet private weak var signUpLoder                  : UIActivityIndicatorView!

    // MARK: - Properties
    var spaceFlag : Bool = true
    var imagePickers = UIImagePickerController()
    var imageSet : Bool  = true
    var imageUrl : String?
    var activeTextField : UITextField?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.signUpImage.isUserInteractionEnabled = true
        self.termAndConditionTextViewFunction()
        self.imageTapGestureRecognizer()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationBackButton()


        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBackButton()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }

        let contentInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }

    private func navigationBackButton() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: StringConstant.arrow.value), for: .normal)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        self.navigationItem.title = "Signup"
        self.navigationItem.leftBarButtonItem = barButton
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func touch() {
        self.view.endEditing(true)
    }

    // MARK: - ImageTapGestureRecognizer Function
    private func imageTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.self.imageViewTapped(_:)))
        signUpImage.addGestureRecognizer(tap)
    }

    // MARK: - SignUp Button
    @IBAction private func signupBtn(_ sender: UIButton) {
        guard let fullName = fullName.text else {return}
        guard let mobileNumber = mobileNumber.text , CommonFunction.commonFunction.isValidaPhoneNumber(phoneNumber: mobileNumber)
        else {
            return }
        guard let email = email.text , CommonFunction.commonFunction.isValidEmailAddress(emailAddressString: email) else {
            return }
        guard let password = password.text else {return}
        signUpLoder.startAnimating()
        let signupInstanceModel = FDSignUpViewModel()
        signupInstanceModel.credentials.fullName = fullName
        signupInstanceModel.credentials.phoneNumber = "+91\(mobileNumber)"
        signupInstanceModel.credentials.email = email
        signupInstanceModel.credentials.password = password
        signupInstanceModel.credentials.imageUrl = imageUrl
        signupInstanceModel.apiCall()
        signUpSuccessfully = {
            guard let vc = CommonFunction.commonFunction.instantiate(vc: ViewController.welcomeAboard.value, from: Storyboard.main.value) as? FDWelcomeAboard else {return}
            vc.name = fullName
            self.navigationController?.pushViewController(vc, animated: true)
            self.signUpLoder.stopAnimating()
        }
    }

    // MARK: - Login Button
    @IBAction private func loginButton(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)

    }

    // MARK: - All TextField Action
    @IBAction private func signupextFieldsAction(_ sender: UITextField) {
        self.allFieldCheck()
        switch sender {

        case email :
            if email.text!.isEmpty {
                self.emailTitle.isHidden = true
            } else {
                self.emailTitle.isHidden = false
            }

        case fullName : if fullName.text!.isEmpty {
            self.fullNameTitle.isHidden = true
        } else {
            self.fullNameTitle.isHidden = false
        }

        case mobileNumber : if mobileNumber.text!.isEmpty {
            self.mobileNumberTitle.isHidden = true
        } else {
            self.mobileNumberTitle.isHidden = false
        }

        case password : if password.text!.isEmpty {
            self.passwordTitle.isHidden = true
        } else {
            self.passwordTitle.isHidden = false
        }

        default : break
        }

        switch sender {

        case email : if email.text!.isEmpty {
            self.emailWarningMessage.isHidden = true
        }
        case password : if password!.text!.isEmpty {
            self.passwordWarningMessage.isHidden = true
        }

        default : break
        }
    }

    // MARK: - Image TapGesture Action
    @objc private func imageViewTapped(_ imageView: UIImage) {
        if imageSet {
            CommonFunction.commonFunction.showActionSheet(vc: self, title: "Please Select Profile Image", message: "Select Option", photoLibrary: "Photo Library", cancel: "Cancel", removeImageTitle: "",cameraTitle : "Camera", photoLibreryAction: { [self] in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    self.imagePickers.delegate = self
                    self.imagePickers.sourceType = .photoLibrary
                    self.imagePickers.allowsEditing = true
                    present(imagePickers, animated: true,completion: nil)
                }
            }, cancelAction: {}, removeImageAction: {} , cameraAction : {
                let alert = UIAlertController(title: "Confirmation Message", message: "Camera Is Under Process", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            })
        } else {
            CommonFunction.commonFunction.showActionSheet(vc: self, title: "Please Select Profile Image", message: "Select Option", photoLibrary: "Photo Library", cancel: "Cancel", removeImageTitle: "Remove Image", cameraTitle : "Camera", photoLibreryAction: { [self] in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    self.imagePickers.delegate = self
                    self.imagePickers.sourceType = .photoLibrary
                    self.imagePickers.allowsEditing = true
                    present(imagePickers, animated: true,completion: nil)
                }
            }, cancelAction: {}, removeImageAction: {
                self.signUpImage.image = UIImage(named:"cameraFrame")
                self.imageSet = true
                self.cameraButton.isHidden = false
                self.allFieldCheck()
            }, cameraAction : {
                let alert = UIAlertController(title: "Confirmation Message", message: "Camera Is Under Process", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            )
        }
    }

    // MARK: - All Field Check
    private func allFieldCheck() {
        guard let fullName = fullName.text  else {return}
        guard let mobileNum = mobileNumber.text else {return}
        guard let email = email.text  else {return}
        guard let password = password.text else {return}
        if fullName.count >= 3  && CommonFunction.commonFunction.validateFullName(name: fullName) && CommonFunction.commonFunction.isValidEmailAddress(emailAddressString: email) && CommonFunction.commonFunction.isValidatePassword(password: password) && mobileNum.count == 10 && imageSet == false {
            self.signupButton.isUserInteractionEnabled = true
            self.signupButton.backgroundColor = ColorAssest.englishLanguageButtonColor.color
        } else {
            self.signupButton.isUserInteractionEnabled = false
            self.signupButton.backgroundColor = ColorAssest.textColor.color
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Extension Text Field Delegate
extension FDSignupVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullName     : fullName.resignFirstResponder()
            mobileNumber.becomeFirstResponder()
        case mobileNumber : mobileNumber.resignFirstResponder()
            email.becomeFirstResponder()
        case email        : email.resignFirstResponder()
            password.becomeFirstResponder()
        case password     : password.resignFirstResponder()
        default : break
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        switch textField {

        case email : emailWarningMessage.isHidden = true

        case fullName : fullNameWarningMessage.isHidden = true

        case mobileNumber : mobileNumberWarningMessage.isHidden = true

        case password : passwordWarningMessage.isHidden = true

        default : break

        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField {
        case fullName     : self.fullNameWarningMessage.isHidden = true

        case email        : self.emailWarningMessage.isHidden = true

        case mobileNumber : self.emailWarningMessage.isHidden = true

        default : break
        }

        switch textField {

        case mobileNumber :
            let accept : Bool
            let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            accept = string == numberFiltered
            let maxLength = 10
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength && accept

        default:
            return true
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        switch textField {

        case fullName :
            if CommonFunction.commonFunction.validateFullName(name: fullName.text!) || fullName.text!.isEmpty {
                self.fullNameWarningMessage.isHidden = true
            } else {
                self.fullNameWarningMessage.isHidden = false
            }

        case email :
            if CommonFunction.commonFunction.isValidEmailAddress(emailAddressString: email.text!) || email.text!.isEmpty {
                self.emailWarningMessage.isHidden = true
            } else {
                self.emailWarningMessage.isHidden = false
            }

        case mobileNumber :
            if mobileNumber.text?.count == 10 || mobileNumber.text!.isEmpty {
                self.mobileNumberWarningMessage.isHidden = true
            } else {
                self.mobileNumberWarningMessage.isHidden = false
            }

        case password :
            if CommonFunction.commonFunction.isValidatePassword(password: password.text!) || password.text!.isEmpty {
                self.passwordWarningMessage.isHidden = true
            } else {
                self.passwordWarningMessage.isHidden = false
            }

        default : break
        }

        return true
    }
}

// MARK: - Text View Delegate

extension FDSignupVC : UITextViewDelegate {

    private func termAndConditionTextViewFunction () {
        let text = NSMutableAttributedString(string: "By sign up, you are agreeing to the ")
        text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, text.length))
        let selectablePart = NSMutableAttributedString(string: "Terms & Conditions")
        selectablePart.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSMakeRange(0, selectablePart.length))
        text.append(selectablePart)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        termAndConditionTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        termAndConditionTextView.attributedText = text
        termAndConditionTextView.isEditable = false
        termAndConditionTextView.isSelectable = true
        self.termAndConditionTextView.delegate = self
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}

// MARK: - Extension ImagePickerControllerDelegate
extension FDSignupVC :  UIImagePickerControllerDelegate ,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        signUpImage.image = image
        self.FIRData()
        self.imageSet = false
        self.cameraButton.isHidden = true
        self.allFieldCheck()
    }
}
// MARK: - Country Code Action Sheet
extension FDSignupVC {

    @IBAction private func countryCodeButton(_ sender : UIButton) {
        self.allCountryCode()
    }

    private func allCountryCode() {
        let countryCode = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let code91 = UIAlertAction(title: "+91", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle( "+91", for: .normal)
        })
        let code92 = UIAlertAction(title: "+92", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle("+92", for: .normal)
        })
        let code93 = UIAlertAction(title: "+93", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle("+93", for: .normal)
        })
        let code94 = UIAlertAction(title: "+94", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle("+94", for: .normal)
        })
        let code95 = UIAlertAction(title: "+95", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle("+95", for: .normal)
        })
        let code96 = UIAlertAction(title: "+96", style: .default, handler: {_ in
            self.countryCodeBtn.setTitle("+96", for: .normal)
        })
        countryCode.addAction(code91)
        countryCode.addAction(code92)
        countryCode.addAction(code93)
        countryCode.addAction(code94)
        countryCode.addAction(code95)
        countryCode.addAction(code96)
        self.present(countryCode, animated: true, completion: nil)
    }
}

extension FDSignupVC {

    func uploadImage (_ image : UIImage , completion : @escaping (_ url :URL?) -> Void) {
        let storageRef = Storage.storage().reference().child(UUID().uuidString + ".png")
        let imagedata = signUpImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imagedata!, metadata: metaData) { metaData, error  in
            if error == nil {
                print("Success")
                storageRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                print("\(String(describing: error?.localizedDescription))")
                completion(nil)
            }
        }
    }

    func FIRData() {
        self.uploadImage(self.signUpImage.image!) { url in
            print("Url")
            guard let url = url else {
                return
            }
            print(url)
           self.imageUrl = "\(url)"
        }
    }
}
