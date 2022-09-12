////
////  GoogleLogin.swift
////  FoodDonation
////
////  Created by Nitish Kumar on 25/04/22.
////
//
//import Foundation
//import GoogleSignIn
//
//class GoogleSignIn {
//
//      // MARK: - Google SignIn Method
//       func googleSignin(_ VC : UIViewController) {
//
//        let signInConfig = GIDConfiguration.init(clientID: "505800088713-5hlm7l7e87s5br2fkeo6v6dav5oldd9d.apps.googleusercontent.com")
//        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: VC) { user, error in
//            guard error == nil else { return }
//            guard error == nil else { return }
//            guard let user = user else { return }
//            let emailAddress = user.profile?.email
//            let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//            print("Email Address : \(String(describing: emailAddress))\nFull Name : \(String(describing: fullName))\ngiven Name : \(String(describing: givenName))\nFamilyName : \(String(describing: familyName))")
//            if user.profile!.hasImage {
//                       // crash here !!!!!!!! cannot get imageUrl here, why?
//                       // let imageUrl = user.profile.imageURLWithDimension(120)
//                let imageUrl = user.profile?.imageURL(withDimension: 480)
//                print(" image url: ", imageUrl?.absoluteString ?? "")
//                   }
//        }
//     }
//}
