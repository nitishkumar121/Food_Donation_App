//
//  UserDefault.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 16/06/22.
//

import Foundation
class UserDefault {
    static var shared = UserDefault()
    private let defaults = UserDefaults.standard
    func saveData<T> (_ val : T , key : String) {
        defaults.set(val, forKey: key)
    }
    func fetchStringData(_ key : String) -> String {
        return defaults.string(forKey: key) ?? "Not Found"
    }
}
extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
