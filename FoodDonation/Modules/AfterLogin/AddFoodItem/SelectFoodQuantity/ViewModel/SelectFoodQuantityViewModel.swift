//
//  SelectFoodQuantityViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 29/06/22.
//

import Foundation

var enterFoodQuantity : ( (_ setFoodQuantity : String ) -> Void )?
var setFoodQuantity  : ( () -> Void )?

class SelectFoodQuantityViewModel {

    var foodQuantity : String? {
        didSet {
            guard let foodQuantity = foodQuantity else {return}
            enterFoodQuantity?(foodQuantity)
        }
    }
}
