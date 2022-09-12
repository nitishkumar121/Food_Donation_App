//
//  SelectFoodExpiryDayViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 29/06/22.
//

import Foundation

var enterDay : ( (_ setFoodQuantity : String ) -> Void )?
var setFoodDay  : ( () -> Void )?

class SelectFoodExpiryDayViewModel {

    var foodDay : String? {
        didSet {
            guard let foodDay = foodDay else {return}
            enterDay?(foodDay)
        }
    }
}
