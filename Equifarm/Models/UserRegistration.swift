//
//  UserRegistration.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 8/26/24.
//

import Foundation

struct UserRegistration: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var phoneNo: String
    var nationalId: String
    var role: String
    var latitude: Double
    var longitude: Double
}
