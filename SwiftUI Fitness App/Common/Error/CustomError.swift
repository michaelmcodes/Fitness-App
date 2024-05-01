//
//  CustomError.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

enum CustomError: LocalizedError {
    case mainError(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .mainError(description):
            return description
        case let .default(description):
            return description ?? "Something went wrong"
        }
    }
}
