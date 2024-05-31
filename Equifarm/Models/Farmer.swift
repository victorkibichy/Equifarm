//
//  Farmer.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/29/24.
//


import Foundation

struct Farmer: Codable {
     private var firstName: String
     private var lastName: String
     private var nationalID: String
     private var email: String
     private var phoneNumber: String
     private var password: String
     private var confirmPassword: String
     private var selectedRoleIndex : IndexPath?
}
