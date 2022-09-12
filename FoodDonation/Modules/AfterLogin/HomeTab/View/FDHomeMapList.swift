//
//  FDHomeMapList.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 01/06/22.
//

import UIKit

class FDHomeMapList: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var mapListView : UIView!
    @IBOutlet private weak var mapListTableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapListView.dropShadow()
        nibLoad()
    }
    private func nibLoad () {
        let nib = UINib(nibName: ViewController.IdentifierName.homeMapListCell.value, bundle: nil)
        mapListTableView.register(nib, forCellReuseIdentifier: ViewController.IdentifierName.homeMapListCell.value)
    }

}
extension FDHomeMapList : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mapListTableView.dequeueReusableCell(withIdentifier: ViewController.IdentifierName.homeMapListCell.value, for: indexPath) as? HomeMapListCell else {return UITableViewCell()}
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 5000
    }
}
