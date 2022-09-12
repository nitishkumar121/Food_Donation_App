//
//  ForgotPasswordViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 16/06/22.
//

import Foundation
var sentOtpMail : (() -> Void)?

class ForgotPasswordViewModel {
    var credential = ForgotPasswordModel()

    func apiCall() {
        let networkManager = NetworkManager(endpoint: Endpoint.forgotPassword.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(credential)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ForgotModel.self) { userRegistrationResponse in

                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        sentOtpMail?()
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
