//
//  FDHomeTabModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 13/07/22.
//

import Foundation

// MARK: - Welcome
struct LocationCoordinates: Encodable {
    var lattitude, longitude: Double?
}

class FDHomeTabModel {

    var currentLocation = LocationCoordinates(lattitude: 0.0, longitude: 0.0)

    // MARK: - Post API Method
      func apiCall() {
        let networkManager = NetworkManager(endpoint: Endpoint.signup.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(currentLocation)
            print(String(decoding: encodedRequest, as: UTF8.self))
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<ForgotModel>.self) { userRegistrationResponse in

                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                       debugPrint("Successfully Save Location")
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
