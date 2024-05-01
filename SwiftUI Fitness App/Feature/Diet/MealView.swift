//
//  MealView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct MealView: View {
    var meal: Meal
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CGFloat(Constants.globalRadius))
                .fill(Color.offWhite)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 6, y: 6)
                .shadow(color: Color.white.opacity(0.7), radius: 6, x: -5, y: -5)
            
            VStack(spacing: 14) {
                HStack {
                    Text(meal.name)
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                    Spacer()
                }
                HStack {
                    Text(meal.description)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .lineLimit(3)
                    Spacer()
                }
                HStack {
                    Text(meal.calories)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    + Text(" Calories")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(meal: Diet.dummyData[0].meals[0])
    }
}
