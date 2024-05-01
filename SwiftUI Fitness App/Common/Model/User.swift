//
//  User.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

struct User: Identifiable, Hashable {
    var id: String?
    var email: String
    var isUserRegistrationStatusPending: Bool
    var username: String
    var password: String
}

struct UserInformation {
    var isUserRegistrationStatusPending: Bool?
    var username: String?
    var profileImage: String
    var age: String
    var gender: String
    var weight: String
    var height: String
    var fitnessGoal: String
    var exerciseType: String
    var dietType: String
}
