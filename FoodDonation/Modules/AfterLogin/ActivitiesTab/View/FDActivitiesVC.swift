//
//  FDActivitiesVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 01/06/22.
//
import UIKit
import Foundation
import WMSegmentControl
import CoreMIDI

class FDActivitiesVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var activityTableView : UITableView!
    @IBOutlet private(set) weak var segmentController : WMSegment!
    @IBOutlet private weak var sectionHeader : UIView!
    @IBOutlet private weak var sectionHeaderTitle : UILabel!

    // MARK: - Properties
    var segmentIndeex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        activityTableView.register(UINib(nibName: "\(FirstTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        segmentController.bottomBarHeight = 1
        segmentController.selectorType = .bottomBar
        activityTableView.register(UINib(nibName: "OtherTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherTableViewCell")
        activityTableView.register(UINib(nibName: "ClaimsTableCell", bundle: nil), forCellReuseIdentifier: "ClaimsTableCell")
        activityTableView.separatorStyle = .none
    }

    @IBAction private func segmentButton(_ sender : WMSegment) {
        print("Index = \(segmentController.selectedSegmentIndex)")
        segmentIndeex = segmentController.selectedSegmentIndex
        UIView.transition(with: activityTableView, duration: 0.33, options: .transitionCrossDissolve, animations: {
            () -> Void in
            self.activityTableView.scrollToTop()
            self.activityTableView.reloadData()
            
        }, completion: nil)
    }
}

extension UIScrollView {
    
    /// Method to scroll to top
    /// - Parameter animated: Bool value which determine whether animated or not
    func scrollToTop(animated: Bool = true) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}

extension FDActivitiesVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return 1
        default : if segmentIndeex == 0 {
            return 4
        } else {
            return 20
        }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 : guard let cell = activityTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as? FirstTableViewCell else {return UITableViewCell()}
            if segmentIndeex == 1 {
                cell.mapButton.isHidden = true
            }
            cell.selectionStyle = .none
            return cell
        default :
            if segmentIndeex == 0 {
                guard let cell = activityTableView.dequeueReusableCell(withIdentifier: "ClaimsTableCell", for: indexPath) as? ClaimsTableCell else {return UITableViewCell()}
                cell.selectionStyle = .none
                if indexPath.row == 3 {
                    cell.progressView.isHidden = true
                }
                return cell
            } else {
                guard let cell = activityTableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as? OtherTableViewCell else {return UITableViewCell()}
                cell.selectionStyle = .none
                return cell
            }
         }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentIndeex == 0 {
            sectionHeaderTitle.text = "Other Claims"
        } else {
            sectionHeaderTitle.text = "Claim Requests"
        }
        return sectionHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0 : return 0
        default : return 50
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 : return view.frame.height / 2
        default : if segmentIndeex == 0 {
            return 100
        } else {
            return 80
          }
        }
    }
}
