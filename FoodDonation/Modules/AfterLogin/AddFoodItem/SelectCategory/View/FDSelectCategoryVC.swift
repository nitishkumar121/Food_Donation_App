//
//  FDSelectCategoryVC.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 05/06/22.
//

import UIKit

class FDSelectCategoryVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var selectCategoryTableView : UITableView!

    // MARK: - Properties
    var flag : Bool = true

    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryTableView.register(UINib(nibName: "selectCategoryTableView", bundle: nil), forCellReuseIdentifier: "selectCategoryTableView")
        selectCategoryTableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        selectCategoryTableView.reloadData()
    }

    // MARK: - ClearAll Button
    @IBAction private func clearAllButton(_ sender : UIButton!) {
        Category.shared.clearAll()
        selectCategoryTableView.reloadData()
    }

    // MARK: - Done Button Action
    @IBAction private func doneBtn(_ sender : UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Back Button Action
    @IBAction private func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FDSelectCategoryVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StringConstant.category.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = selectCategoryTableView.dequeueReusableCell(withIdentifier: "SelectCategoryTableCell", for: indexPath) as? SelectCategoryTableCell else {return UITableViewCell()}
        cell.categoryName.text = StringConstant.category[indexPath.row]

        let abc = StringConstant.category[indexPath.row]
        cell.categorySelectCheckImage.image = Category.shared.isSelect(abc)
        categorySelect = { index in
            Category.shared.selectedImage(StringConstant.category[index])
            self.selectCategoryTableView.reloadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorySelect?(indexPath.row)
    }
}
