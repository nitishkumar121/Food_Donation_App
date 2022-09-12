//
//  FDHelpAndSupportVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 02/06/22.
//

import UIKit

class FDHelpAndSupportVC: UIViewController {

    var activeTextField : UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func backBarButton() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        var shouldMoveViewUp = false
        if let activeTextField = activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

}

extension FDHelpAndSupportVC : UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeTextField = nil
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextField = textView
    }
}
