//
//  Helper.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 16/06/22.
//

import Foundation

enum ApiError : Error {
    case responseProblem
    case decodingProblem
    case otherProblem
}
enum Endpoint: String {
    case signup = "user/signup"
    case login = "user/login"
    case forgotPassword = "user/forgotpassword/sentOtpMail"
    case verifyOtpMail = "user/forgotpassword/verifyOtpMail"
    case resetpassword = "user/resetpassword"
    case getUserProfile = "getUserProfile"
    case saveLocation   = "user/saveLocation"
}
