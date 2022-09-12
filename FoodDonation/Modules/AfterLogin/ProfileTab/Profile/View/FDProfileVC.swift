//
//  FDProfileVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 02/06/22.
//

import UIKit

class FDProfileVC: UIViewController {
    @IBOutlet private(set) weak var userName : UILabel!
    @IBOutlet private(set) weak var userEmail : UILabel!
    @IBOutlet private(set) weak var userPost : UILabel!
    @IBOutlet private(set) weak var userClaim : UILabel!
    @IBOutlet private(set) weak var mobileNumber : UILabel!
    @IBOutlet private(set) weak var profileImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let instance = ProfileViewModel()
        instance.getProfileApiCall()
        getProfileData = { data in
            self.downloadImage(from: URL(string: data.getUserprofile.imageURL)!)
            self.userName.text = data.getUserprofile.fullName
            self.userEmail.text = data.getUserprofile.email
            self.mobileNumber.text = data.getUserprofile.phoneNumber
            self.userClaim.text = "\(data.claims)"
            self.userPost.text = "\(data.posts)"
            print(data.getUserprofile.imageURL)
        }
    }
    
    @IBAction private func settingButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDSettingVC.value, from: Storyboard.profileTab.value), animated: true)
    }
    @IBAction private func joinUsButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDJoinUsVC.value, from: Storyboard.profileTab.value), animated: true)
    }
    @IBAction private func contributorButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDContributorVC.value, from: Storyboard.profileTab.value), animated: true)
    }
    @IBAction private func helpAndSupportButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDHelpAndSupportVC.value, from:Storyboard.profileTab.value), animated: true)
    }

    @IBAction private func editProfileButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.editProfile.value, from:Storyboard.profileTab.value), animated: true)
    }

    @IBAction private func historyButton() {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDHistory.value, from:Storyboard.profileTab.value), animated: true)
    }

}

extension FDProfileVC {
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self!.profileImage.image = UIImage(data: data)
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
