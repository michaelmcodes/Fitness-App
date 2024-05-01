//
//  DietItemDetailView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct DietItemDetailView: View {
    var diet: Diet
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                AsyncCenterCroppedImageView(url: URL(string: diet.image)!)
                    .frame(height: 260)
                    .cornerRadius(30)
                    .padding(.top)
                
                HStack {
                    VStack {
                        HStack {
                            Text(diet.title)
                                .font(.system(size: 28))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        HStack {
                            Text(diet.time)
                                .font(.system(size: 18))
                                .fontWeight(.light)
                            Spacer()
                        }
                    }
                    Spacer()
                    Text(diet.calories)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    + Text("\nCalories")
                        .font(.system(size: 14))
                        .fontWeight(.thin)
                    
                    
                }
                ForEach(diet.meals, id: \.self) { meal in
                    MealView(meal: meal)
                }
            }
            .padding()
            .overlay(BackButtonView(color: .black), alignment: .top)
        }
        .padding(.top, 1)
        .navigationBarBackButtonHidden()
        
        
        
    }
}

struct DietItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DietItemDetailView(diet: Diet.dummyData[0])
    }
}
