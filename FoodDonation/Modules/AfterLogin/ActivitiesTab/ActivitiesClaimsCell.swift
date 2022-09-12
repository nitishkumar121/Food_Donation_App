////
////  ActivitiesClaimsCell.swift
////  FoodDonation
////
////  Created by Nitish Kumar on 15/06/22.
////
//
//import UIKit
//
//class ActivitiesClaimsCell: UICollectionViewCell {
//    @IBOutlet private(set) weak var activitiesClaimsTableView : UITableView!
//    var imageStore : UIImage = ImageAssets.tutorialGraphicOne.image
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        activitiesClaimsTableView.register(UINib(nibName: "ActivitiesClaimsTableCell", bundle: nil), forCellReuseIdentifier: "ActivitiesClaimsTableCell")
//        self.activitiesClaimsTableView.delegate = self
//        self.activitiesClaimsTableView.dataSource = self
//        activitiesClaimsTableView.separatorStyle = .none
//    }
//    
//}
//extension ActivitiesClaimsCell : UITableViewDelegate , UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = activitiesClaimsTableView.dequeueReusableCell(withIdentifier: "ActivitiesClaimsTableCell", for: indexPath) as? ActivitiesClaimsTableCell else {return UITableViewCell()}
//        
//        cell.cellImage.image = imageStore
//        imageChange = {
//            self.imageStore = ImageAssets.tutorialGraphicOne.image
//            self.activitiesClaimsTableView.reloadData()
//        }
//        image2Change = {
//            self.imageStore  = ImageAssets.tutorialGraphicThree.image
//            self.activitiesClaimsTableView.reloadData()
//        }
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//        
//    }
//}
