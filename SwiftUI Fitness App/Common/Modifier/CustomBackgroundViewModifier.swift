//
//  CustomBackgroundViewModifier.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct CustomBackgroundViewModifier: ViewModifier {
    var cornerRadius: CGFloat = CGFloat(Constants.globalRadius)
    var backgroundColor: Color = .gray.opacity(0.2)
    
    func body(content: Content) -> some View {
        content
        .padding()
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        
    }
}
