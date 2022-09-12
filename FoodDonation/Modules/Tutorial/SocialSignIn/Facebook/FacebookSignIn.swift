//
//  FacebookLogin.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 25/04/22.
//

import Foundation
import FBSDKLoginKit

class FacebookSignIn {

    // MARK: - Facebook Login Method
    func faceBookLogin( _ vc : UIViewController) {
        loginWithFacebook(fromViewController: vc , completion: { (result, error) in
            if error == nil,let token = result?.token {
                self.getInfo(token: token.tokenString, success: { (result) in
                    print(result)
                }, failure: { (error) in
                    print(error ?? "")
                })
            }
        })
    }
    // MARK: Facebook Login Manager
    private func loginWithFacebook(fromViewController viewController: UIViewController, completion: @escaping LoginManagerLoginResultBlock) {
        if  AccessToken.current != nil {
            facebookLogout()
        }
        let permissions = ["email", "public_profile"]
        let login = LoginManager()
        login.logIn(permissions: permissions, from: viewController) { (result, error) in
            if let res = result,res.isCancelled {
                completion(nil,error)
            } else {
                completion(result,error)
            }
        }
    }
    // MARK: - Facebook Get Information Method
    private func getInfo(token: String,success: @escaping ((FacebookUser) -> Void),
                         failure: @escaping ((Error?) -> Void)) {
        let params = ["fields": "email, name, gender, first_name, last_name, birthday, cover, currency, devices, education, hometown, link, locale, location, relationship_status, website, work, picture.type(large)"]
        let request = GraphRequest(graphPath: "me", parameters: params)
        request.start(completion: {connection, result, error in
            if let result = result as? [String : Any] {
                success(FacebookUser(withDictionary: result, token))
            } else {
                failure(error)
            }
        })
    }
}

    // MARK: - Facebook Logout Method
    private func facebookLogout() {
       LoginManager().logOut()
       let cooki  : HTTPCookieStorage! = HTTPCookieStorage.shared
       if let strorage = HTTPCookieStorage.shared.cookies {
        for cookie in strorage {
            cooki.deleteCookie(cookie)
        }
    }
}

// MARK: - FACEBOOK MODEL
   struct FacebookUser {
        let dictionary : [String:Any]
        let id: String
        let email: String
        let name: String
        let first_name: String
        let last_name: String
        let link: String
        let gender: String
        var cover: URL?
        var picture: URL?
        let is_verified : Bool
        var image : String = ""
        let token : String

        init(withDictionary dict: [String:Any],_ token: String) {

            dictionary = dict

            id = "\(dict["id"] ?? "")"
            name = "\(dict["name"] ?? "")"
            first_name = "\(dict["first_name"] ?? "")"
            email = "\(dict["email"] ?? "")"
            gender = "\(dict["gender"] ?? "")"

            if let picture = dict["picture"] as? [String:Any],let data = picture["data"] as? [String:Any] {
                image = "\(data["url"] ?? "")"
                self.picture = URL(string: "\(data["url"] ?? "")")

            }
            if let cover = dict["cover"] as? [String:Any] {
                self.cover = URL(string: "\(cover["source"] ?? "")")
            }
            link = "\(dict["link"] ?? "")"
            last_name = "\(dict["last_name"] ?? "")"
            is_verified = "\(dict["is_verified"] ?? "")" == "0" ? false : true
            self.token = token
        }
    }
