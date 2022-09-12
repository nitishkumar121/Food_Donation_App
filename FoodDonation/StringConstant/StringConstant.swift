//
//  StringConstant.swift
//  FoodDonation
//
//  Created by appinventiv on 08/04/22.
//

import UIKit

enum TutorialScreenStringConstant : String , CaseIterable {
    case headingOne   = "Pick Up On Location!"
    case headingTwo   = "Your Rescue The Food!"
    case headingThree = "Connect With Us!"

    case subHeadingOne = "You pick up the food that you have claimed."
    case subHeadingTwo = "You claim the food on the app and it is reserved in your name in the restaurant."
    case subHeadingThree = "Help us in reaching out  to others by becoming a volunteer."

    var getValue : String {
        return self.rawValue
    }
}

enum StringConstant: String {

    case custom  = "Custom"
    case arrow   = "arrow"
    case show    = "Show"
    case hide    = "Hide"
    case baseUrl = "http://44.202.78.173:5000/"

    enum Aleart : String {

        case message = "Message"
        case underProcess = "Under Process"
        case ok = "OK"

        var value : String {
            return self.rawValue
        }
    }

    var value: String {
        return self.rawValue
    }

    // MARK: - Global Constants
    static let category = ["Pure vegetarian","Non vegetarian","vegan","Breakfast","Lunch","Evening snack","Dinner"]

}

enum Storyboard: String {
    case main       = "Main"
    case map        = "Map"
    case homeTab    = "HomeTab"
    case profileTab = "ProfileTab"
    case addFoodTab = "AddFoodTab"

    var value : String {
        return self.rawValue
    }
}

enum ViewController : String {
    case loginScreen        = "LoginScreen"
    case tabBarVC           = "TabBar"
    case signupVC           = "FDSignupVC"
    case forgotPassword     = "forgotPassword"
    case welcomeAboard      = "welcomeAboard"
    case fDHomeMapList      = "FDHomeMapList"
    case fDFilterVC         = "FDFilterVC"
    case fDSettingVC        = "FDSettingVC"
    case fDJoinUsVC         = "FDJoinUsVC"
    case fDContributorVC    = "FDContributorVC"
    case fDHelpAndSupportVC = "FDHelpAndSupportVC"
    case fDHomeFoodDetail   = "FDHomeFoodDetail"
    case editProfile        = "EditProfile"
    case fDHistory          = "FDHistory"

    var value : String {
        return self.rawValue
    }

    enum IdentifierName : String {
        case tutorialViewModel     = "TutorialViewModel"
        case emailVerify           = "emailVerify"
        case homeMapListCell       = "HomeMapListCell"
        case homeTabCell           = "HomeTabCell"
        case detailsCollectionCell = "FoodDetailsCollectionCell"
        case annotationIdentifier  = "AnnotationIdentifier"

        var value : String {
            return self.rawValue
        }
    }
}

final class Category {

    static let shared = Category()
    var category: [String : Bool] = ["Pure vegetarian" : false,"Non vegetarian" : false,"vegan" : false,"Breakfast" : false,"Lunch" : false,"Evening snack" : false,"Dinner" : false]

    var isSelectedImage : UIImage {
     return UIImage(named: "icSelectedTick")!
    }

    var isUnSelectedImage : UIImage {
        return UIImage(named: "icUnselectedTick")!
    }

    func isSelect ( _ key : String) -> UIImage {
        guard let value = category[key] else {return UIImage()}
        if value {
            return Category.shared.isSelectedImage
        } else {
            return Category.shared.isUnSelectedImage
        }
    }

    func selectedImage (_ key : String) {
        guard let value = category[key] else {return}
        if value {
            category[key] = false
        } else {
            category[key] = true
        }
    }

    func selectedCategory() -> [String] {
        return category.filter({$0.value == true}).map({$0.key}).sorted()
    }

    func clearAll() {
        category.forEach { (key: String, _: Bool) in
            category[key] = false
        }
    }
}
