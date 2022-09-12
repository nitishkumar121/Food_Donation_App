import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class FDTutorialVC : UIViewController {

    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var googleBtn: UIButton!
    @IBOutlet private weak var emailBtn: UIButton!
    private var currentIndex: Int = 0
    private var pages: [Pages] = Pages.allCases
    private var pageController: UIPageViewController?
  //  private let googleSignIn = GoogleSignIn()
    private let facebookSignIn = FacebookSignIn()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.setupPageController()
    }

    // MARK: - Google SignIn Button
    @IBAction private func buttonGoogle(_ sender: Any) {
        // user
       // googleSignIn.googleSignin(self)
    }

    // MARK: - Set Up PageController
    private func setupPageController() {
        self.view.layoutIfNeeded()
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.bounds = self.myView.frame
        self.myView.clipsToBounds = true
        self.addChild(self.pageController!)
        pageController?.view.frame = self.view.frame
        self.myView.addSubview(self.pageController!.view)
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboard.main.value, bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: ViewController.IdentifierName.tutorialViewModel.value) as? TutorialViewModel {
            nextViewController.bindData(page: pages[0])
            self.pageController?.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            self.pageController?.didMove(toParent: self)
        }

    }

    @IBAction private func facebookButton(_ sender : UIButton) {
        facebookSignIn.faceBookLogin(self)
    }

    @IBAction private func continuewithEmailButton(_ sender : UIButton) {

        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.loginScreen.value, from: Storyboard.main.value), animated: true)

    }
}

// MARK: - FDTutorialVC Data Source And Delegate
extension FDTutorialVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? TutorialViewModel else {
            return nil
        }
        var index = currentVC.page.index
        pageChangedTo(index: index)
        if index == 0 {
            return nil
        }
        index -= 1
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboard.main.value, bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: ViewController.IdentifierName.tutorialViewModel.value) as? TutorialViewModel {
            nextViewController.bindData(page: pages[index])
            return nextViewController
        }
        return UIViewController()
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? TutorialViewModel else {
            return nil
        }
        var index = currentVC.page.index
        pageChangedTo(index: index)
        if index >= self.pages.count - 1 {
            return nil
        }
        index += 1
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboard.main.value, bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: ViewController.IdentifierName.tutorialViewModel.value) as? TutorialViewModel {
            nextViewController.bindData(page: pages[index])
            return nextViewController
        }
        return UIViewController()
    }

    func pageChangedTo(index:Int) {
        pageControl.currentPage = index
    }
}
