//
//  SignupViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Combine
import XNavigation

final class SingupViewModel: ObservableObject {
    @Published var user: User = .init(email: "", isUserRegistrationStatusPending: true, username: "", password: "")
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
    }
    
    func signup(navigation: Navigation) {
        if  user.email.isEmpty ||
                user.username.isEmpty ||
                user.password.isEmpty {
            return
        }
        self.isLoading = true
        mainRepo.signup(user: user)
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
                    Util.setUserDefaultsBool(value: true, key: Constants.USER_DEFAULTS_IS_USER_LOGGED_IN)
                    navigation.pushView(UserInfoView(), animated: true)
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
