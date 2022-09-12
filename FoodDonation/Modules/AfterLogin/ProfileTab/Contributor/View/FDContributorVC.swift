//
//  FDContributorVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 02/06/22.
//

import UIKit

class FDContributorVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var contributorTableView : UITableView!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contributorTableView.delegate = self
        contributorTableView.dataSource = self
        contributorTableView.register(UINib(nibName: "ContributorTableCell", bundle: nil), forCellReuseIdentifier: "ContributorTableCell")
        contributorTableView.separatorStyle = .none
    }

    enum Contributor : String , CaseIterable {
        case platinum = "Platinum"
        case gold     = "Gold"
        case silver   = "Silver"
    }

    @IBAction private func backBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FDContributorVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contributor.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contributorTableView.dequeueReusableCell(withIdentifier: "ContributorTableCell", for: indexPath) as? ContributorTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.contributorTitle.text = Contributor.allCases[indexPath.row].rawValue
        if indexPath.row - 1 == indexPath.count - 1 {
            cell.separatorView.isHidden = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
