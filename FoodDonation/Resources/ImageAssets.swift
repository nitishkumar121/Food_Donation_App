import UIKit

enum ImageAssets : String , CaseIterable {

    // MARK: - Splash Screen Image
    case splashScreenBackground
    case splashScreenIcon

    // MARK: - Tutorial BackgroundImage
    case tutorialGraphicOne
    case tutorialGraphicTwo
    case tutorialGraphicThree

    // MARK: -
    case icMapList
    case icMapIcon
    case icUnselectedTick
    case icSelectedTick
    case icmylocation
    case icmappins

    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

enum JoinUsIconImage : String , CaseIterable {
    case restaurant = "icJoinRestaurant"
    case volunteer  = "icJoinVolunteer"
    case ambassador = "icJoinAmbassador"

    var image : UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

enum JoinUsWalpaper : String , CaseIterable {
    case restaurant = "icJoinRestaurantBg"
    case volunteer  = "icJoinVolunteerBg"
    case ambassador = "icJoinAmbassadorBg"

    var image : UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

enum ColorAssest : String , CaseIterable {
    case textColor
    case englishLanguageButtonColor
    case black
    case shadowsColor
    case blue
    case yellow
    case red
    var  color : UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }

}
