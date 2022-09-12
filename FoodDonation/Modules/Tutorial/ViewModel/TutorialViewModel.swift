import UIKit

class TutorialViewModel : UIViewController {
    var index : Int = 0
        var page: Pages = .pageOne
    @IBOutlet weak private var heading              : UILabel!
    @IBOutlet weak private var subHeading           : UILabel!
    @IBOutlet weak private var backgroundImage      : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage.image = page.backgroundImage
        self.heading.text = page.heading
        self.subHeading.text = page.subHeading
    }
    func bindData(page:Pages) {
            self.page = page
      }

}
