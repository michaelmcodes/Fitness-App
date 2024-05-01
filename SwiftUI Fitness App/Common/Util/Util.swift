//
//  Util.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

class Util {
    static func getListOfHeightBasedOnFeet() -> [String] {
        var result: [String] = []
        for i in 4..<7 {
            for j in 0..<12 {
                result.append("\(i)' \(j)\"")
            }
        }
        return result
    }
    
    static func setUserDefaultsBool(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func setUserDefaultsString(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
