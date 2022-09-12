//
//  ResetPasswordViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 16/06/22.
//

import Foundation
var resetPasswordSuccessfully : ( () -> Void)?
class ResetPasswordViewModel {
    var emailId : String?
    var credentials = ResetPasswordModel()

    func apiCall() {
        let networkManager = NetworkManager(endpoint: Endpoint.resetpassword.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            print(credentials)
            let encodedRequest = try JSONEncoder().encode(credentials)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ForgotModel.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        resetPasswordSuccessfully?()
                       // print(data.message)
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            print("Credentials are invalid")
                        }
                        debugPrint("response problem")
                    case .otherProblem :
                        debugPrint("other problem")
                    }
                }
            }
        } catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
