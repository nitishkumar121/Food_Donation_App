//
//  APIDataModel.swift
//  FoodDonation
//
// Created by Nitish Kumar on 13/06/22.
//

import Foundation
import UIKit
//
struct ApiResponceModel<T:Decodable> : Decodable {
    let statusCode: Int
    let status: Bool
  //  let message: String
    let data: T?
}

// MARK: - DataClass
struct LoginClass : Codable {
    let id, token: String
}

struct SignUpClass: Codable {
    let fullname, email, phoneNumber: String
    let imageURL, verificationLink: String

    enum CodingKeys: String, CodingKey {
        case fullname, email, phoneNumber
        case imageURL = "ImageUrl"
        case verificationLink
    }
}

struct ForgotModel: Codable {
    let statusCode: Int
    let status: Bool
//    let message: String
}
