//
//  FDHistory.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 01/07/22.
//

import UIKit
import WMSegmentControl

class FDHistory: UIViewController {
    // MARK: - Outlet
    @IBOutlet private weak var historyTableView : UITableView!
    @IBOutlet private(set) weak var segmentController : WMSegment!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentController.bottomBarHeight = 1
        segmentController.selectorType = .bottomBar
        historyTableView.register(UINib(nibName: "HistoryTableCell", bundle: nil), forCellReuseIdentifier: "HistoryTableCell")
        historyTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

    @IBAction private func segmentButton(_ sender : WMSegment) {
        print("Index = \(segmentController.selectedSegmentIndex)")
    }

    // MARK: - Back Button Action
    @IBAction private func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FDHistory : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath)
        cell.selectionStyle = .none
        cell.layer.applySketchShadow(alpha: 0.08, _x: 0, _y: 3, blur: 10, spread: 0)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index : \(indexPath.row)")
    }
}
