//
//  MainRepository.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Combine
import UIKit

protocol MainRepositoryProtocol {
    func logout() -> AnyPublisher<Void, CustomError>
    func login(email: String, password: String) -> AnyPublisher<Bool, CustomError>
    func signup(user: User) -> AnyPublisher<Void, CustomError>
    func saveUserInfo(userInformation: UserInformation) -> AnyPublisher<Void, CustomError>
    func getUserInfo() -> AnyPublisher<UserInformation, CustomError>
    func uploadImageToStorage(image: UIImage) -> AnyPublisher<String, CustomError>
    func getWorkouts(exerciseType: ExerciseType) -> AnyPublisher<[Workout], CustomError>
    func getDiets(dietType: DietType) -> AnyPublisher<[Diet], CustomError>
}

final class MainRepository: MainRepositoryProtocol {
    
    let currentUser = Auth.auth().currentUser
    let database = Database.database()
    
    func logout() -> AnyPublisher<Void, CustomError> {
        return Future<Void, CustomError> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(.default(description: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Bool, CustomError> {
        return Future<Bool, CustomError> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    if let user = result?.user {
                        self.database
                            .reference()
                            .child(Constants.FIREBASE_USERS_NODE)
                            .child(user.uid)
                            .observeSingleEvent(of: .value, with: { snapshot in
                                let value = snapshot.value as! [String : AnyObject]
                                if let isUserRegistrationStatusPending = value[Constants.FIREBASE_IS_USER_REGISTRATION_STATUS_PENDING_NODE] as? Bool,
                                   let exerciseType = value[Constants.FIREBASE_EXERCISE_TYPE_NODE] as? String,
                                   let dietType = value[Constants.FIREBASE_DIET_TYPE_NODE] as? String
                                {
                                    Util.setUserDefaultsString(value: exerciseType, key: Constants.USER_DEFAULTS_EXERCISE_TYPE)
                                    Util.setUserDefaultsString(value: dietType, key: Constants.USER_DEFAULTS_DIET_TYPE)
                                    promise(.success(isUserRegistrationStatusPending))
                                } else {
                                    promise(.failure(.default()))
                                }
                            })
                        
                    } else {
                        promise(.failure(.default()))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signup(user: User) -> AnyPublisher<Void, CustomError> {
        return Future<Void, CustomError> { promise in
            Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    if let createdUser = result?.user {
                        let userDictionary: [String: Any] = [Constants.FIREBASE_EMAIL_NODE: user.email,
                                                             Constants.FIREBASE_USERNAME_NODE: user.username,
                                                             Constants.FIREBASE_IS_USER_REGISTRATION_STATUS_PENDING_NODE: user.isUserRegistrationStatusPending,
                        ]
                        self.database
                            .reference()
                            .child(Constants.FIREBASE_USERS_NODE)
                            .child(createdUser.uid)
                            .setValue(userDictionary) { (error, ref) -> Void in
                                if let error = error {
                                    promise(.failure(.mainError(description: error.localizedDescription)))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        
                    } else {
                        promise(.failure(.default()))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func saveUserInfo(userInformation: UserInformation) -> AnyPublisher<Void, CustomError> {
        return Future<Void, CustomError> { promise in
            let userDictionary: [String: Any] = [
                Constants.FIREBASE_IS_USER_REGISTRATION_STATUS_PENDING_NODE: userInformation.isUserRegistrationStatusPending ?? false,
                Constants.FIREBASE_PROFILE_IMAGE_NODE: userInformation.profileImage,
                Constants.FIREBASE_AGE_NODE: userInformation.age,
                Constants.FIREBASE_GENDER_NODE: userInformation.gender,
                Constants.FIREBASE_WEIGHT_NODE: userInformation.weight,
                Constants.FIREBASE_HEIGHT_NODE: userInformation.height,
                Constants.FIREBASE_FITNESS_GOAL_NODE: userInformation.fitnessGoal,
                Constants.FIREBASE_EXERCISE_TYPE_NODE: userInformation.exerciseType,
                Constants.FIREBASE_DIET_TYPE_NODE: userInformation.dietType,
            ]
            if let currentUser = self.currentUser {
                self.database
                    .reference()
                    .child(Constants.FIREBASE_USERS_NODE)
                    .child(currentUser.uid)
                    .updateChildValues(userDictionary) { (error, ref) -> Void in
                        if let error = error {
                            promise(.failure(.mainError(description: error.localizedDescription)))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func getUserInfo() -> AnyPublisher<UserInformation, CustomError> {
        return Future<UserInformation, CustomError> { promise in
            if let currentUser = self.currentUser {
                self.database
                    .reference()
                    .child(Constants.FIREBASE_USERS_NODE)
                    .child(currentUser.uid)
                    .observeSingleEvent(of: .value, with: { snapshot in
                        let value = snapshot.value as! [String : AnyObject]
                        if let profileImage = value[Constants.FIREBASE_PROFILE_IMAGE_NODE] as? String,
                           let username = value[Constants.FIREBASE_USERNAME_NODE] as? String,
                           let age = value[Constants.FIREBASE_AGE_NODE] as? String,
                           let gender = value[Constants.FIREBASE_GENDER_NODE] as? String,
                           let height = value[Constants.FIREBASE_HEIGHT_NODE] as? String,
                           let weight = value[Constants.FIREBASE_WEIGHT_NODE] as? String,
                           let fitnessGoal = value[Constants.FIREBASE_FITNESS_GOAL_NODE] as? String,
                           let exerciseType = value[Constants.FIREBASE_EXERCISE_TYPE_NODE] as? String,
                           let dietType = value[Constants.FIREBASE_DIET_TYPE_NODE] as? String {
                            promise(.success(.init(
                                username: username,
                                profileImage: profileImage,
                                age: age,
                                gender: gender,
                                weight: weight,
                                height: height,
                                fitnessGoal: fitnessGoal,
                                exerciseType: exerciseType,
                                dietType: dietType)))
                        } else {
                            promise(.failure(.default()))
                        }
                    })
            } else {
                promise(.failure(.default()))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func uploadImageToStorage(image: UIImage) -> AnyPublisher<String, CustomError> {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("Photos/\(UUID().uuidString).jpg")
        let data = image.jpegData(compressionQuality: 0.6)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        return Future<String, CustomError> { promise in
            if let data = data {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        promise(.failure(.mainError(description: error.localizedDescription)))
                    }
                    
                    if let metadata = metadata {
                        print("Metadata: ", metadata)
                        storageRef.downloadURL { (url, error) in
                            if let error = error {
                                promise(.failure(.mainError(description: error.localizedDescription)))
                            } else if let url = url {
                                promise(.success(url.absoluteString))
                            }
                            
                        }
                        
                    }
                }
            } else {
                promise(.failure(.mainError(description: "Data is nil")))
            }
        }.eraseToAnyPublisher()
    }
    
    func getDiets(dietType: DietType) -> AnyPublisher<[Diet], CustomError> {
        return Future<[Diet], CustomError> { promise in
            
            var dietTypeNodeChildName: String {
                switch (dietType) {
                case .cut:
                    return "cut"
                case .bulk:
                    return "bulk"
                case .maintaining:
                    return "maintaining"
                }
            }
            
            self.database
                .reference()
                .child(Constants.FIREBASE_FITNESS_NODE)
                .child(Constants.FIREBASE_DIETS_NODE)
                .child(dietTypeNodeChildName)
                .observeSingleEvent(of: .value, with: { snapshot in
                    var diets: [Diet] = []
                    
                    for dietSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                        let value = dietSnapshot.value as! [String : AnyObject]
                        
                        if let title = value[Constants.FIREBASE_TITLE_NODE] as? String,
                           let time = value[Constants.FIREBASE_TIME_NODE] as? String,
                           let image = value[Constants.FIREBASE_IMAGE_NODE] as? String,
                           let calories = value[Constants.FIREBASE_CALORIE_NODE] as? String,
                           
                            let mealsArray = value[Constants.FIREBASE_MEALS_NODE] as? NSArray {
                            
                            var meals: [Meal] = []
                            for meal in mealsArray {
                                let meal = meal as? [String: String]
                                
                                let name = meal?[Constants.FIREBASE_NAME_NODE]
                                let description = meal?[Constants.FIREBASE_DESCRIPTION_NODE]
                                let calorie = meal?[Constants.FIREBASE_CALORIE_NODE]
                                meals.append(.init(name: name ?? "", description: description ?? "", calories: calorie ?? ""))
                            }
                            
                            let diet: Diet = .init(title: title, image: image, time: time, calories: calories, meals: meals)
                            diets.append(diet)
                        }
                        
                    }
                    promise(.success(diets))
                })
            
        }.eraseToAnyPublisher()
    }
    
    func getWorkouts(exerciseType: ExerciseType) -> AnyPublisher<[Workout], CustomError> {
        return Future<[Workout], CustomError> { promise in
            
            var workoutTypeNodeChildName: String {
                switch (exerciseType) {
                case .lifting:
                    return "lifting"
                case .cardio:
                    return "cardio"
                }
            }
            
            self.database
                .reference()
                .child(Constants.FIREBASE_FITNESS_NODE)
                .child(Constants.FIREBASE_WORKOUTS_NODE)
                .child(workoutTypeNodeChildName)
                .observeSingleEvent(of: .value, with: { snapshot in
                    var workouts: [Workout] = []
                    
                    for dietSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                        let value = dietSnapshot.value as! [String : AnyObject]
                        
                        if let title = value[Constants.FIREBASE_TITLE_NODE] as? String,
                           let duration = value[Constants.FIREBASE_DURATION_NODE] as? String,
                           let image = value[Constants.FIREBASE_IMAGE_NODE] as? String,
                           let description = value[Constants.FIREBASE_DESCRIPTION_NODE] as? String,
                           let movementsArray = value[Constants.FIREBASE_MOVEMENTS_NODE] as? NSArray {
                            
                            var movements: [Movement] = []
                            
                            for movement in movementsArray {
                                let movement = movement as? [String: String]
                                
                                let title = movement?[Constants.FIREBASE_TITLE_NODE]
                                let target = movement?[Constants.FIREBASE_TARGET_NODE]
                                let quantity = movement?[Constants.FIREBASE_QUANTITY_NODE]
                                let image = movement?[Constants.FIREBASE_IMAGE_NODE]
                                movements.append(.init(title: title ?? "", target: target ?? "", quantity: quantity ?? "", image: image ?? ""))
                            }
                            
                            let workout: Workout = .init(title: title, duration: duration, description: description, image: image, movements: movements)
                            workouts.append(workout)
                        }
                    }
                    promise(.success(workouts))
                })
            
        }.eraseToAnyPublisher()
    }
    
    
}
