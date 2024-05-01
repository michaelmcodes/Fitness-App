//
//  BackButtonView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var color: Color = .white
    var geometry: GeometryProxy? = nil
    
    var body: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack(spacing: 2) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(color)
                        .font(.system(size: 18))
                    Text("Back")
                        .foregroundColor(color)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    
                }
            }
            Spacer()
            
        }
        .if(geometry != nil) { view in
            view
                .padding(.top, geometry?.safeAreaInsets.top != 0 ? geometry?.safeAreaInsets.top : 20)
        }
        .padding(.horizontal)
    }
}
