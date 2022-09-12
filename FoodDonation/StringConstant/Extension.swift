//
//  Extension.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 01/06/22.
//

import Foundation
import UIKit

extension UIView {

  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: 0, height: 1.5)
    layer.shadowRadius = 5
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
