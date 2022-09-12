//
//  TutorialScreenEnums.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 08/04/22.
//

import UIKit
import Foundation

enum Pages: CaseIterable {

    case pageZero
    case pageOne
    case pageTwo

    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        }
    }

    var backgroundImage : UIImage {
        switch self {
        case .pageZero:
            return ImageAssets.tutorialGraphicOne.image
        case .pageOne:
            return ImageAssets.tutorialGraphicTwo.image
        case .pageTwo:
            return ImageAssets.tutorialGraphicThree.image
        }
    }
    var heading : String {
        switch self {
        case .pageZero:
            return TutorialScreenStringConstant.headingOne.getValue
        case .pageOne:
            return TutorialScreenStringConstant.headingTwo.getValue
        case .pageTwo:
            return TutorialScreenStringConstant.headingThree.getValue
        }
    }
    var subHeading : String {
        switch self {
        case .pageZero:
            return TutorialScreenStringConstant.subHeadingOne.getValue
        case .pageOne:
            return TutorialScreenStringConstant.subHeadingTwo.getValue
        case .pageTwo:
            return TutorialScreenStringConstant.subHeadingThree.getValue
        }
    }
}
