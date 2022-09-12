//
//  FDJoinUsVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 02/06/22.
//

import UIKit

class FDJoinUsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var joinUsTableView : UITableView!

    // MARK: - Enum
    enum JoinUs : String , CaseIterable {
        case restaurant = "Restaurant"
        case volunteer  = "Volunteer"
        case ambassador = "Ambassador"
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        joinUsTableView.register(UINib(nibName: "JoinUsTableCell", bundle: nil), forCellReuseIdentifier: "JoinUsTableCell")
        joinUsTableView.separatorStyle = .none
    }

    @IBAction private func backBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FDJoinUsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        JoinUs.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = joinUsTableView.dequeueReusableCell(withIdentifier: "JoinUsTableCell", for: indexPath) as? JoinUsTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.joinUsTitleName.text = JoinUs.allCases[indexPath.row].rawValue
        cell.joinUsIconImage.image = JoinUsIconImage.allCases[indexPath.row].image
        cell.joinUsImage.image = JoinUsWalpaper.allCases[indexPath.row].image
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
