//
//  WorkoutViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Combine
import Foundation

final class WorkoutViewModel: ObservableObject {
    @Published var exerciseType: ExerciseType = ExerciseType(rawValue: (UserDefaults.standard.string(forKey: Constants.USER_DEFAULTS_EXERCISE_TYPE) ?? ExerciseType.lifting.stringValue)) ?? .lifting
    @Published var workouts: [Workout] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
        self.getWorkouts()
    }
    
    private func getWorkouts() {
        self.isLoading = true
        mainRepo.getWorkouts(exerciseType: exerciseType)
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
            } receiveValue: { [weak self] workouts in
                guard let self = self else { return }
                self.workouts = workouts
                
            }.store(in: &cancellables)
    }
}
