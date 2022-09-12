//
//  CommonExtension.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 30/06/22.
//

import Foundation
import UIKit

extension CALayer {
  func applySketchShadow (
    color: UIColor = ColorAssest.shadowsColor.color,alpha: Float = 0.15,_x: CGFloat = 0,_y : CGFloat = 1.5,
    blur: CGFloat = 8,
    spread: CGFloat = 2) {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: _x, height: _y)
        shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
