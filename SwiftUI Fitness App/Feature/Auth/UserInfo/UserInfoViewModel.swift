//
//  UserInfoViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation
import Combine
import XNavigation
import UIKit

final class UserInfoViewModel: ObservableObject {
    @Published var isShowingPhotoPicker = false
    @Published var isShowingBottomSheet = false
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
    }
    
    @Published var currentUserInfo: UserInfo = .age
    @Published var age = 20
    @Published var weight = 160
    @Published var height = "5' 9\""
    @Published var gender: Gender = .male
    @Published var fitnessGoal: FitnessGoal = .losingWeight
    @Published var exerciseType: ExerciseType = .lifting
    @Published var dietType: DietType = .cut
    
    @Published var ageSelected = false
    @Published var genderSelected = false
    @Published var weightSelected = false
    @Published var heightSelected = false
    @Published var fitnessGoalSelected = false
    @Published var exerciseTypeSelected = false
    @Published var dietTypeSelected = false
    
    func saveChanges(navigation: Navigation, uiImage: UIImage) {
        if  !ageSelected ||
                !genderSelected ||
                !weightSelected ||
                !heightSelected ||
                !fitnessGoalSelected ||
                !exerciseTypeSelected ||
                !dietTypeSelected {
            return
        }
        if uiImage == UIImage(named: "profileImagePlaceholder") {
            saveUserInfo(navigation: navigation)
        } else {
            uploadImageToStorage(navigation: navigation, image: uiImage)
        }
    }
    
    private func uploadImageToStorage(navigation: Navigation, image: UIImage) {
        self.isLoading = true
        mainRepo.uploadImageToStorage(image: image)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case let .failure(error) :
                    self.showError = true
                    self.isLoading = false
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] downloadUrl in
                guard let self = self else { return }
                saveUserInfo(navigation: navigation, profileImage: downloadUrl)
            }
            .store(in: &cancellables)
        
    }
    
    private func saveUserInfo(navigation: Navigation, profileImage: String? = nil) {
        self.isLoading = true
        
        let userInformation: UserInformation = .init(isUserRegistrationStatusPending: false, profileImage: profileImage ?? "", age: String(age), gender: gender.stringValue, weight: String(weight), height: height, fitnessGoal: fitnessGoal.stringValue, exerciseType: exerciseType.stringValue, dietType: dietType.stringValue)
        mainRepo.saveUserInfo(userInformation: userInformation)
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
                    Util.setUserDefaultsString(value: userInformation.exerciseType, key: Constants.USER_DEFAULTS_EXERCISE_TYPE)
                    Util.setUserDefaultsString(value: userInformation.dietType, key: Constants.FIREBASE_DIET_TYPE_NODE)
                    navigation.pushView(TabBarContainerView(), animated: true)
                    
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
}
