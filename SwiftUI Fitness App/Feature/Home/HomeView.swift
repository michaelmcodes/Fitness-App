//
//  HomeView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import XNavigation
import AlertToast

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    HStack {
                        Text(viewModel.isLoading ? "Loading..." : "Hi, \(viewModel.username)!")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .lineLimit(1)
                        Spacer()
                        
                        AsyncCenterCroppedImageView(url: URL(string: viewModel.profileImage))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 4)
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        
                        HStack{
                            Text("Today's Step Count")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Spacer()
                            Button {
                                viewModel.logout(navigation: navigation)
                            } label: {
                                Text("Logout")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 20))
                            }
                        }
                        
                        if viewModel.isHealthKitAuthorized {
                            
                            Group {
                                Text("\(viewModel.userStepCount) ")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                + Text("Steps")
                                    .font(.title2)
                                    .fontWeight(.light)
                            }
                            .frame(height: 80)
                        } else {
                            VStack {
                                Text("Please Authorize Health!")
                                    .font(.title3)
                                    .foregroundColor(.red)
                                
                                Button {
                                    viewModel.healthRequest()
                                } label: {
                                    Text("Authorize HealthKit")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color(.orange))
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        
                        
                        HStack{
                            Text("Personal Information")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        if viewModel.isLoading {
                            LoadingView()
                                .frame(minHeight: proxy.size.height / 2)
                        } else {
                            
                            PersonalInfoView(selectButtonDisabled: true, age: $viewModel.age, weight: $viewModel.weight, height: $viewModel.height, gender: $viewModel.gender, fitnessGoal: $viewModel.fitnessGoal, exerciseType: $viewModel.exerciseType, dietType: $viewModel.dietType, onSelectValue: {_ in})
                        }
                        
                    }
                    
                }
                .toast(isPresenting: $viewModel.showError){
                    AlertToast(type: .error(.red), title: viewModel.error)
                }
                .padding()
                .onAppear {
                    viewModel.readStepsTakenToday()
                    viewModel.getUserInfo()
                }
            }
            .padding(.top, 1)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
