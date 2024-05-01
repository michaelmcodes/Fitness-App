//
//  UserInfoView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import XNavigation

struct UserInfoView: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject var viewModel = UserInfoViewModel()
    
    @State var avatarImage = UIImage(named: "profileImagePlaceholder")!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .frame(height: geometry.size.height)
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        VStack {
                            Text("User Info")
                                .font(.system(size: 36))
                                .fontWeight(.heavy)
                            Text("Tell us more about you")
                                .fontWeight(.light)
                            
                            Spacer()
                                .frame(height: 40)
                            
                            Image(uiImage: avatarImage)
                                .resizable()
                                .scaledToFill()
                                .background(.black)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 4)
                            
                            
                            
                            Button {
                                viewModel.isShowingPhotoPicker = true
                            } label: {
                                Text("Select photo")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                                .frame(height: 40)
                            
                            PersonalInfoView(age: $viewModel.age, weight: $viewModel.weight, height: $viewModel.height, gender: $viewModel.gender, fitnessGoal: $viewModel.fitnessGoal, exerciseType: $viewModel.exerciseType, dietType: $viewModel.dietType, ageSelected: $viewModel.ageSelected, genderSelected: $viewModel.genderSelected, weightSelected: $viewModel.weightSelected, heightSelected: $viewModel.heightSelected, fitnessGoalSelected: $viewModel.fitnessGoalSelected, exerciseTypeSelected: $viewModel.exerciseTypeSelected, dietTypeSelected: $viewModel.dietTypeSelected, onSelectValue: { userInfo in
                                viewModel.currentUserInfo = userInfo
                                viewModel.isShowingBottomSheet = true
                            })
                            
                            Button {
                                withAnimation {
                                    viewModel.saveChanges(navigation: navigation, uiImage: avatarImage)
                                }
                            } label: {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                        .padding(.horizontal)
                                } else {
                                    Text("Save")
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
                                }
                            }
                            .disabled(viewModel.isLoading)
                            .buttonStyle(CustomButtonStyle())
                            .padding(.top)
                            
                        }
                        .padding(.vertical)
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
                
                
                BottomSheet(isShowing: $viewModel.isShowingBottomSheet, content:
                                AnyView(VStack{
                    switch(viewModel.currentUserInfo) {
                    case .age:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.ageSelected, pickerContent: AnyView(AgePickerView(age: $viewModel.age)))
                        
                    case .gender:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.genderSelected, pickerContent: AnyView(GenderPickerView(gender: $viewModel.gender)))
                        
                    case .weight:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.weightSelected, pickerContent: AnyView(WeightPickerView(weight: $viewModel.weight)))
                        
                    case .height:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.heightSelected, pickerContent: AnyView(HeightPickerView(height: $viewModel.height)))
                        
                    case .fitnessGoal:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.fitnessGoalSelected, pickerContent: AnyView(FitnessGoalPickerView(fitnessGoal: $viewModel.fitnessGoal)))
                        
                    case .exerciseType:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.exerciseTypeSelected, pickerContent: AnyView(ExerciseTypePickerView(type: $viewModel.exerciseType)))
                        
                    case .dietType:
                        UserInfoPickerView(isShowingBottomSheet: $viewModel.isShowingBottomSheet, isSelected: $viewModel.dietTypeSelected, pickerContent: AnyView(DietTypePickerView(type: $viewModel.dietType)))
                    }
                }))
                
                
            }
            
            
            
        }.sheet(isPresented: $viewModel.isShowingPhotoPicker){
            PhotoPicker(avatarImage: $avatarImage)
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct PersonalInfoTemplate: View {
    var title: String
    @Binding var value: Int
    @Binding var selected: Bool
    var unit: String
    var selectValue: () -> ()
    var buttonDisabled: Bool? = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.light)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
            
            Button {
                selectValue()
            } label: {
                Group {
                    
                    if selected {
                            TextField("Value", value: $value, formatter: NumberFormatter())
                                .font(.system(size: 26, weight: .heavy))
                                .disabled(true)
                                .multilineTextAlignment(.center)
                        
                    } else {
                        
                        Text("Choose")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                            .padding(.horizontal, 4)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                    }
                }
                .frame(height: 60)
            }
            .disabled(buttonDisabled ?? false)
            
            Text(unit)
                .font(.system(size: 16))
                .fontWeight(.thin)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .modifier(CustomBackgroundViewModifier())
    }
}

struct HeightInfoTemplate: View {
    var title: String
    @Binding var value: String
    @Binding var selected: Bool
    var unit: String
    var selectValue: () -> ()
    var buttonDisabled: Bool? = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.light)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
            
            Button {
                selectValue()
            } label: {
                Group {
                    
                    if selected {
                        Text($value.wrappedValue)
                            .foregroundColor(.black)
                            .font(.system(size: 28, weight: .heavy))
                        
                    } else {
                        
                        Text("Choose")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                            .padding(.horizontal, 4)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                    }
                }
                .frame(height: 60)
            }
            .disabled(buttonDisabled ?? false)
            
            Text(unit)
                .font(.system(size: 16))
                .fontWeight(.thin)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .modifier(CustomBackgroundViewModifier())
    }
}

struct GeneralInfoTemplate: View {
    var title: String
    @Binding var value: String
    @Binding var selected: Bool
    var description: String
    var selectValue: () -> ()
    var buttonDisabled: Bool? = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.light)
            
            HStack(spacing: 10) {
                Text(description)
                    .font(.system(size: 26))
                    .fontWeight(.thin)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                
                Button {
                    selectValue()
                } label: {
                    if selected {
                        
                        Text($value.wrappedValue)
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                            .fontWeight(.heavy)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                    } else {
                        
                        Text("Choose")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                            .padding(.horizontal, 4)
                        
                    }
                    
                }
                .disabled(buttonDisabled ?? false)
            }
            
        }
        .frame(maxWidth: .infinity)
        .modifier(CustomBackgroundViewModifier())
    }
}


struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
