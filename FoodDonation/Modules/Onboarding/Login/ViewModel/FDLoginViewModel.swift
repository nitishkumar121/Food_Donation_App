import Foundation

var loginSucces : ((String) -> Void)?
var loginFail : ((String) -> Void)?

class FDLoginViewModel {

    // MARK: - Properties
    var credentials = Credentials()

    func apiCall() {
        let networkManager = NetworkManager(endpoint: Endpoint.login.rawValue)
        networkManager.requestUrl.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encodedRequest = try JSONEncoder().encode(credentials)
            networkManager.postApiData(requestBody: encodedRequest, resultType: ApiResponceModel<LoginClass>.self) { userRegistrationResponse in

                switch userRegistrationResponse {
                case .success(let data) :
                    DispatchQueue.main.async {
                        loginSucces?(data.data?.token ?? "")
                       // print(data.message)
                    }
                case .failure(let error) :
                    switch error {
                    case .decodingProblem :
                        debugPrint("decoding problem")
                    case .responseProblem :
                        DispatchQueue.main.async {
                            loginFail?("Credentials are invalid")
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
