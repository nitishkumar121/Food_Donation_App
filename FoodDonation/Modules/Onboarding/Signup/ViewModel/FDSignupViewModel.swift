import Foundation
var signUpSuccessfully : ( () -> Void )?

class FDSignUpViewModel {

    // MARK: - Properties
    var credentials = SignupCredentials()
    // MARK: - Post API Method
      func apiCall() {
        let networkManager = NetworkManager(endpoint: Endpoint.signup.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(credentials)
            print(String(decoding: encodedRequest, as: UTF8.self))
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<SignUpClass>.self) { userRegistrationResponse in

                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        signUpSuccessfully?()
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
