//
//  CustomStyleTextFieldModifier.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI


struct CustomStyleTextFieldModifier: ViewModifier {
    var imageName: String
    
    func body(content: Content) -> some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.darkShadow)
            content
        }
        .padding()
        .foregroundColor(.neumorphictextColor)
        .background(Color.white.opacity(0.7))
        .cornerRadius(CGFloat(Constants.globalRadius))
        
    }
}

