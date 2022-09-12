import Foundation

struct SignupCredentials : Encodable {
    var fullName : String?
    var phoneNumber : String?
    var email : String?
    var password : String?
    var imageUrl : String?

    enum CodingKeys: String, CodingKey {
        case fullName
        case phoneNumber
        case password
        case email
        case imageUrl = "ImageUrl"
    }
}
