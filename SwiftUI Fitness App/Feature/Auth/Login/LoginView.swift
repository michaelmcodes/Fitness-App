//
//  LoginView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import XNavigation
import AlertToast

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: LoginField?
    @EnvironmentObject var navigation: Navigation
    
    @Binding var showLoginView: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Login")
                    .foregroundColor(.black)
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                Spacer()
            }
            
            TextField("Email", text: $viewModel.email)
                .foregroundColor(.black)
                .keyboardType(.emailAddress)
                .modifier(CustomStyleTextFieldModifier(imageName: "envelope"))
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .focused($focusedField, equals: .emailField)
                .onSubmit { self.focusNextField($focusedField) }
            
            SecureField("Password", text: $viewModel.password)
                .foregroundColor(.black)
                .modifier(CustomStyleTextFieldModifier(imageName: "lock"))
                .submitLabel(.done)
                .focused($focusedField, equals: .passwordField)
                .onSubmit { hideKeyboard()
                    withAnimation {
                        viewModel.login(navigation: navigation)
                    } }
            
            HStack {
                
                Button {
                    hideKeyboard()
                    withAnimation {
                        viewModel.login(navigation: navigation)
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Login")
                            .fontWeight(.bold)
                    }
                }
                .disabled(viewModel.isLoading)
                .buttonStyle(CustomButtonStyle())
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Do not have an account?")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showLoginView.toggle()
                        }
                    } label: {
                        Text("Register")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.heavy)
                    }
                    
                }
            }
            
        }
        .toast(isPresenting: $viewModel.showError){
            AlertToast(type: .error(.red), title: viewModel.error)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 50)
        .background(Color.loginBoxBackground.opacity(0.7))
        .cornerRadius(CGFloat(Constants.globalRadius))
        
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLoginView: .constant(true))
    }
}
