//
//  CustomButtonStyle.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                    .frame(width: 80)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(CGFloat(Constants.globalRadius))
                    .scaleEffect(configuration.isPressed ? 1.2 : 1)
                    .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}
