import UIKit

class CommonFunction {

    static let commonFunction = CommonFunction()

    // MARK: - Email Address Validation Check

    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            if results.isEmpty {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }

    func validateFullName(name: String) -> Bool {
        let nameRegex = "^(?=.{1,20}$)[A-Za-zÀ-ú][A-Za-zÀ-ú.'-]+(?: [A-Za-zÀ-ú.'-]+)*"
         let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        print(isValidateName)
        return isValidateName
    }

    // MARK: - Mobile Number Validation Check

    func isValidaPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }

    func isValidatePassword(password: String) -> Bool {
        // Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }

    // MARK: - Instantiate ViewController

    func instantiate(vc: String, from storyboard: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        return sb.instantiateViewController(withIdentifier: vc)
    }

    // MARK: - Alert

    func showAlert(vc: UIViewController, title: String = "", message: String = "", okTitle: String, cancel: String = "", okAction: (() -> Void )? = nil, cancelAction:(() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !okTitle.isEmpty {
            let ok = UIAlertAction(title: okTitle, style: .default, handler: { _  in
                okAction?()
            })
            alert.addAction(ok)
        }
        if !cancel.isEmpty {
            let cancel = UIAlertAction(title: cancel, style: .cancel, handler: { _  in
                cancelAction?()
            })
            alert.addAction(cancel)
        }
        vc.present(alert, animated: true, completion: nil)
    }

    // MARK: - Image Selection Action Sheet Alert

    func showActionSheet(vc: UIViewController, title: String = "Message", message: String = "Select Option", photoLibrary : String = "", cancel: String = "", removeImageTitle : String = "",cameraTitle : String = "" ,photoLibreryAction : (() -> Void)? = nil, cancelAction:(() -> Void)? = nil , removeImageAction : (() -> Void)? = nil , cameraAction : (() -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        if !photoLibrary.isEmpty {
            let photoLibrary = UIAlertAction(title: photoLibrary, style: .default, handler: { _  in
                photoLibreryAction?()
            })
            alert.addAction(photoLibrary)
        }
        if !cameraTitle.isEmpty {
            let camera = UIAlertAction(title: cameraTitle, style: .default, handler: { _  in
                cameraAction?()
            })
            alert.addAction(camera)
        }
        if !removeImageTitle.isEmpty {
            let removeImage = UIAlertAction(title: removeImageTitle, style: .default, handler: { _  in
                removeImageAction?()
            })
            alert.addAction(removeImage)
        }
        if !cancel.isEmpty {
            let cancel = UIAlertAction(title: cancel, style: .cancel, handler: { _  in
                cancelAction?()
            })
            alert.addAction(cancel)
        }
        vc.present(alert, animated: true, completion: nil)
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
       let size = image.size
       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height
       var newSize: CGSize
       if widthRatio > heightRatio {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
       }
       let rect = CGRect(origin: .zero, size: newSize)
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return newImage
   }
}
