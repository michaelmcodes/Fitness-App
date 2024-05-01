//
//  DietViewModel.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Combine
import Foundation

final class DietViewModel: ObservableObject {
    @Published var dietType: DietType = DietType(rawValue: (UserDefaults.standard.string(forKey: Constants.USER_DEFAULTS_DIET_TYPE) ?? DietType.cut.stringValue)) ?? .cut
    @Published var diets: [Diet] = Diet.dummyData
    @Published private(set) var isLoading = false
    @Published private(set) var error = ""
    @Published var showError = false
    
    private var mainRepo: MainRepository
    private var cancellables: [AnyCancellable] = []
    
    init(mainRepo: MainRepository = MainRepository()) {
        self.mainRepo = mainRepo
        self.getDiets()
    }
    
    private func getDiets() {
        self.isLoading = true
        mainRepo.getDiets(dietType: dietType)
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
            } receiveValue: { [weak self] diets in
                guard let self = self else { return }
                self.diets = diets
                
            }.store(in: &cancellables)
    }
}
