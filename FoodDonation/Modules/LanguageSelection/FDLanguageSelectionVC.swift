import UIKit

class FDLanguageSelectionVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var languageSelectionView : UIView!
    @IBOutlet private weak var englishLanguageBtn    : UIButton!
    @IBOutlet private weak var arabicLanguageBtn     : UIButton!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arabicLanguageBtn.layer.borderColor = UIColor(red: 213/255, green: 220/255, blue: 233/255, alpha: 1).cgColor
    }

    // MARK: - English Language Selection Button
    @IBAction private func englishLanguage(_ sender: UIButton) {
    }

    // MARK: - Arabic Language Selection Button
    @IBAction private func arabicLanguage(_ sender: UIButton) {
        CommonFunction.commonFunction.showAlert(vc: self, title: StringConstant.Aleart.message.value, message: StringConstant.Aleart.underProcess.value, okTitle: StringConstant.Aleart.ok.value) {} cancelAction: {}
    }
}
