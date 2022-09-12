//
//  LoginManager.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 10/06/22.
//

import Foundation
import UIKit

class NetworkManager {
    var requestUrl : URLRequest
    init(endpoint : String) {
        let baseURL = "\(StringConstant.baseUrl.value)\(endpoint)"
        guard let resourceURL = URL(string: baseURL) else {
            fatalError()
        }
        let request = URLRequest(url: resourceURL)
        self.requestUrl = request
    }

    func postApiData<T:Decodable>(requestBody: Data, resultType: T.Type, completionHandler:@escaping(Result<T,ApiError>) -> Void) {
        requestUrl.httpMethod = "POST"
        requestUrl.httpBody = requestBody
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse , error) in
            guard let jsonData = data, let urlResponse = httpUrlResponse as? HTTPURLResponse  else {
                completionHandler(.failure(.responseProblem))
                return
            }
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            print(prettyPrintedString!)
            print(urlResponse.statusCode)
            if !(200...300).contains(urlResponse.statusCode) {
                completionHandler(.failure(.responseProblem))
                return
            }
            do {
                let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                print(prettyPrintedString!)
                let response = try JSONDecoder().decode(T.self, from: jsonData)
                _=completionHandler(.success(response))
            } catch let error {
                debugPrint(error)
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }

    func getApiData<T:Decodable>(resultType: T.Type, completionHandler:@escaping(Result<T,ApiError>) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            guard let jsonData = responseData , let urlResponse = httpUrlResponse as? HTTPURLResponse else {
                return
            }
            let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            print(prettyPrintedString!)
            print(urlResponse.statusCode)
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                _=completionHandler(.success(result))
            } catch let error {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
}
