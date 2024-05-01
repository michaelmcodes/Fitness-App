//
//  UserInfoPickerView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct UserInfoPickerView: View {
    @Binding var isShowingBottomSheet: Bool
    @Binding var isSelected: Bool
    var pickerContent: AnyView
    
    var body: some View {
        VStack(spacing: 10) {
            pickerContent
                .frame(height: 160)
            HStack {
                Button {
                    isShowingBottomSheet = false
                    isSelected = true
                } label: {
                    Text("Done")
                        .fontWeight(.bold)
                }
                .buttonStyle(CustomButtonStyle())
            }
            
        }
        .padding(.top, 26)
        
    }
}

struct AgePickerView: View {
    @Binding var age: Int
    var lowestAge: Int = 14
    var highestAge: Int = 60
    
    var body: some View {
        Picker("Age", selection: $age) {
            ForEach(lowestAge..<highestAge, id: \.self ) {
                Text("\($0) years old")
            }
        }
        .pickerStyle(.wheel)
    }
}

struct GenderPickerView: View {
    @Binding var gender: Gender
    
    var body: some View {
        Picker("Gender", selection: $gender) {
            ForEach(Gender.allCases, id: \.self ) { gender in
                Text(gender.stringValue)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct WeightPickerView: View {
    @Binding var weight: Int
    var lowestWeight: Int = 90
    var highestWeight: Int = 400
    
    var body: some View {
        Picker("Weight", selection: $weight) {
            ForEach(lowestWeight..<highestWeight, id: \.self ) {
                Text("\($0) lbs")
            }
        }
        .pickerStyle(.wheel)
    }
}

struct HeightPickerView: View {
    @Binding var height: String
    
    var body: some View {
        
        Picker("Height", selection: $height) {
            ForEach(Util.getListOfHeightBasedOnFeet() , id: \.self ) {
                Text($0)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct FitnessGoalPickerView: View {
    @Binding var fitnessGoal: FitnessGoal
    
    var body: some View {
        Picker("Fitness Goal", selection: $fitnessGoal) {
            ForEach(FitnessGoal.allCases, id: \.self ) { goal in
                Text(goal.stringValue)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct ExerciseTypePickerView: View {
    @Binding var type: ExerciseType
    
    var body: some View {
        Picker("Exercise Type", selection: $type) {
            ForEach(ExerciseType.allCases, id: \.self ) { type in
                Text(type.stringValue)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct DietTypePickerView: View {
    @Binding var type: DietType
    
    var body: some View {
        Picker("Diet Type", selection: $type) {
            ForEach(DietType.allCases, id: \.self ) { type in
                Text(type.stringValue)
            }
        }
        .pickerStyle(.wheel)
    }
}
