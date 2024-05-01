//
//  Enums.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

enum LoginField: Int, Hashable {
    case emailField, passwordField
}

enum SignupField: Int, Hashable {
    case emailField, usernameField, passwordField
}

enum UserInfo {
    case age
    case gender
    case weight
    case height
    case fitnessGoal
    case exerciseType
    case dietType
}

enum Gender: String, Hashable, Equatable, CaseIterable {
    case male = "Male"
    case female = "Female"
    
    var stringValue: String {
        get {
            switch self {
            case .male:
                return "Male"
            case .female:
                return "Female"
            }
        }
        mutating set {
            self = Gender(rawValue: newValue) ?? .male
        }
    }
}

enum FitnessGoal: String, Hashable, Equatable, CaseIterable {
    case losingWeight = "Losing Weight"
    case buildingMuscle = "Building Muscle"
    
    var stringValue: String {
        get {
            switch self {
            case .losingWeight:
                return "Losing Weight"
            case .buildingMuscle:
                return "Building Muscle"
            }
        }
        mutating set {
            self = FitnessGoal(rawValue: newValue) ?? .buildingMuscle
        }
    }
}

enum ExerciseType: String, Hashable, Equatable, CaseIterable {
    case lifting = "Lifting"
    case cardio = "Cardio"
    
    var stringValue: String {
        get {
            switch self {
            case .lifting:
                return "Lifting"
            case .cardio:
                return "Cardio"
            }
        }
        mutating set {
            self = ExerciseType(rawValue: newValue) ?? .lifting
        }
    }
}

enum DietType: String, Hashable, Equatable, CaseIterable {
    case cut = "Cut (Weight Loss)"
    case bulk = "Bulk (Weight Gaining)"
    case maintaining = "Maintaining Weight"
    
    var stringValue: String {
        get {
            switch self {
            case .cut:
                return "Cut (Weight Loss)"
            case .bulk:
                return "Bulk (Weight Gaining)"
            case .maintaining:
                return "Maintaining Weight"
            }
        }
        mutating set {
            self = DietType(rawValue: newValue) ?? .cut
        }
    }
}

