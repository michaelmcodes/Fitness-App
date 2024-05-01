//
//  LoginViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation
import Combine
import XNavigation


final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
    }
    
    func login(navigation: Navigation) {
        if  email.isEmpty ||
                password.isEmpty {
            return
        }
        self.isLoading = true
        mainRepo.login(email: email, password: password)
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                    self.showError = true
                    self.isLoading = false
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                case .finished:
                    self.isLoading = false
                    break
                }
            } receiveValue: { isUserRegistrationStatusPending in
                if isUserRegistrationStatusPending {
                    navigation.pushView(UserInfoView(), animated: true)
                } else {
                    self.isLoading = false
                    Util.setUserDefaultsBool(value: true, key: Constants.USER_DEFAULTS_IS_USER_LOGGED_IN)
                    navigation.pushView(TabBarContainerView(), animated: true)
                }
                
            }
            .store(in: &cancellables)
    }
}
