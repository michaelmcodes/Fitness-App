//
//  HomeViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Combine
import HealthKit
import XNavigation

final class HomeViewModel: ObservableObject {
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = "0"
    @Published var isHealthKitAuthorized = false
    
    @Published var username: String = ""
    @Published var profileImage: String = ""
    @Published var age: Int = 0
    @Published var weight: Int = 0
    @Published var height: String = "0"
    @Published var gender: Gender = .male
    @Published var fitnessGoal: FitnessGoal = .buildingMuscle
    @Published var exerciseType: ExerciseType = .lifting
    @Published var dietType: DietType = .cut
    
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
        self.changeAuthorizationStatus()
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        DispatchQueue.main.async { [weak self] in
            switch status {
            case .notDetermined:
                self?.isHealthKitAuthorized = false
            case .sharingDenied:
                self?.isHealthKitAuthorized = false
            case .sharingAuthorized:
                self?.isHealthKitAuthorized = true
            @unknown default:
                self?.isHealthKitAuthorized = false
            }
        }
    }
    
    func getUserInfo() {
        self.isLoading = true
        mainRepo.getUserInfo()
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
            } receiveValue: { [weak self] userInformation in
                guard let self = self else { return }
                self.username = userInformation.username ?? ""
                self.profileImage = userInformation.profileImage
                self.age = Int(userInformation.age) ?? 20
                self.gender = Gender(rawValue: userInformation.gender) ?? .male
                self.weight = Int(userInformation.weight) ?? 200
                self.height = userInformation.height
                self.fitnessGoal = FitnessGoal(rawValue: userInformation.fitnessGoal) ?? .buildingMuscle
                self.exerciseType = ExerciseType(rawValue: userInformation.exerciseType) ?? .lifting
                self.dietType = DietType(rawValue: userInformation.dietType) ?? .cut
                
            }
            .store(in: &cancellables)
    }
    
    func logout(navigation: Navigation) {
        mainRepo.logout()
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                    self.showError = true
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                    break
                case .finished:
                    Util.setUserDefaultsBool(value: false, key: Constants.USER_DEFAULTS_IS_USER_LOGGED_IN)
                    navigation.pushView(AuthenticationView(), animated: true)
                    break
                }
            } receiveValue: { _ in}
            .store(in: &cancellables)
    }
}
