//
//  AuthenticationView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State var showLoginView: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            Image("fitnessImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                if showLoginView {
                    LoginView(showLoginView: $showLoginView)
                        .transition(.scale)
                } else {
                    SignupView(showLoginView: $showLoginView)
                        .transition(.scale)
                }
                
                Spacer()
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
