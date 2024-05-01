//
//  PersonalInfoView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct PersonalInfoView: View {
    
    var selectButtonDisabled: Bool? = false
    
    @Binding var age: Int
    @Binding var weight: Int
    @Binding var height: String
    @Binding var gender: Gender
    @Binding var fitnessGoal: FitnessGoal
    @Binding var exerciseType: ExerciseType
    @Binding var dietType: DietType
    
    var ageSelected: Binding<Bool>? = nil
    var genderSelected: Binding<Bool>? = nil
    var weightSelected: Binding<Bool>? = nil
    var heightSelected: Binding<Bool>? = nil
    var fitnessGoalSelected: Binding<Bool>? = nil
    var exerciseTypeSelected: Binding<Bool>? = nil
    var dietTypeSelected: Binding<Bool>? = nil
    
    var onSelectValue: (UserInfo) -> ()
    
    var body: some View {
            VStack(spacing: 20) {
                
                HStack(spacing: 18) {
                    PersonalInfoTemplate(title: "Age", value: $age, selected: ageSelected ?? .constant(true), unit: "years old", selectValue: {
                        onSelectValue(.age)
                    }, buttonDisabled: selectButtonDisabled ?? false)
                    PersonalInfoTemplate(title: "Weight", value: $weight, selected: weightSelected ?? .constant(true), unit: "lbs", selectValue: {
                        onSelectValue(.weight)
                    }, buttonDisabled: selectButtonDisabled ?? false)
                    HeightInfoTemplate(title: "Height", value: $height, selected: heightSelected ?? .constant(true), unit: "feet", selectValue: {
                        onSelectValue(.height)
                    }, buttonDisabled: selectButtonDisabled ?? false)
                }
                
                GeneralInfoTemplate(title: "Gender", value: $gender.stringValue, selected: genderSelected ?? .constant(true), description: "I'm a", selectValue: {
                    onSelectValue(.gender)
                }, buttonDisabled: selectButtonDisabled ?? false)
                
                
                GeneralInfoTemplate(title: "Fitness Goal", value: $fitnessGoal.stringValue, selected: fitnessGoalSelected ?? .constant(true), description: "I am thinking of", selectValue: {
                    onSelectValue(.fitnessGoal)
                }, buttonDisabled: selectButtonDisabled ?? false)
                
                
                GeneralInfoTemplate(title: "Exercise Type", value: $exerciseType.stringValue, selected: exerciseTypeSelected ?? .constant(true), description: "I want to start", selectValue: {
                    onSelectValue(.exerciseType)
                }, buttonDisabled: selectButtonDisabled ?? false)
                
                GeneralInfoTemplate(title: "Diet Type", value: $dietType.stringValue, selected: dietTypeSelected ?? .constant(true), description: "I am considering a", selectValue: {
                    onSelectValue(.dietType)
                }, buttonDisabled: selectButtonDisabled ?? false)
            
        }
    }
}

//struct PersonalInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalInfoView()
//    }
//}
