//
//  ContentView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn = UserDefaults.standard.bool(forKey: Constants.USER_DEFAULTS_IS_USER_LOGGED_IN)
    
    var body: some View {
        NavigationView {
            if isUserLoggedIn {
                TabBarContainerView()
            } else {
                AuthenticationView()
            }
                
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
