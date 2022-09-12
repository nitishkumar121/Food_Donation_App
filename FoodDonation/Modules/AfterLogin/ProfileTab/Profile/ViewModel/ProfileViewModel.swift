//
//  ProfileViewModel.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 17/06/22.
//

import Foundation

var getProfileData : ( (_ userData : ProfileModel) -> Void)?
class ProfileViewModel {

    func getProfileApiCall() {
        var token = String()
        let networkManager = NetworkManager(endpoint: Endpoint.getUserProfile.rawValue)
        if UserDefaults.standard.valueExists(forKey: "token") {
            token = UserDefault.shared.fetchStringData("token")
        } else {
            print("Session Expired Login again")
        }
        debugPrint(token)
        networkManager.requestUrl.httpMethod = "get"
        networkManager.requestUrl.addValue("\(token)",forHTTPHeaderField: "Authorization")
        networkManager.getApiData(resultType: ProfileModel.self) { userRegistrationResponse in
            switch userRegistrationResponse {
            case .success(let data) :
                DispatchQueue.main.async {
                    getProfileData?(data)
                }
            case .failure(let error) :
                switch error {
                case .decodingProblem :
                    debugPrint("decoding problem")
                case .responseProblem :
                    debugPrint("Server authorization failed")
                case .otherProblem :
                    debugPrint("other problem")
                }
            }
        }
    }
}
