//
//  OTPViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 16/06/22.
//

import Foundation

var verifyOtp : ( () -> Void )?
class OTPViewModel {
    var credentials = OTPCredentials()
    var obj = ForgotPasswordModel()

    func apiCallForverifyOtpMail() {
        let networkManager = NetworkManager(endpoint: Endpoint.verifyOtpMail.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            print(credentials)
            let encodedRequest = try JSONEncoder().encode(credentials)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ForgotModel.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        verifyOtp?()
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

    func apiCallOtpSend() {
        let networkManager = NetworkManager(endpoint: Endpoint.forgotPassword.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            print(credentials)
            let encodedRequest = try JSONEncoder().encode(obj)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ForgotModel.self) { userRegistrationResponse in
                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
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
