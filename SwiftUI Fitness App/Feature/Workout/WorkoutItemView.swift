//
//  WorkoutItemView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import XNavigation

struct WorkoutItemView: View {
    @EnvironmentObject var navigation: Navigation
    var workout: Workout
    
    var body: some View {
        Button {
            navigation.pushView(WorkoutItemDetailView(workout: workout), animated: true)
        } label: {
            ZStack {
                AsyncCenterCroppedImageView(url: URL(string: workout.image)!)
            }
            .frame(height: 200)
            .cornerRadius(CGFloat(Constants.globalRadius))
            .padding(.vertical, 4)
            .overlay(
                VStack(spacing: 6) {
                    HStack {
                        Text(workout.title)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        
                        Spacer()
                        Text(workout.duration)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.light)
                    }
                    
                    HStack {
                        Text("Includes ")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.light)
                        +
                        Text("\(workout.movements.count) ")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        +
                        Text("movements.")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.light)
                        Spacer()
                    }
                    
                }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(CGFloat(Constants.globalRadius), corners: [.bottomLeft, .bottomRight])
                    .padding(.vertical, 4)
                
                , alignment: .bottom)
        }
        
        
    }
}


struct WorkoutItemView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutItemView(workout: .init(title: "Push Day", duration: "1 month", description: "", image: "https://www.muscleandfitness.com/wp-content/uploads/2016/09/Bodybuilder-Working-Out-His-Upper-Body-With-Cable-Crossover-Exercise.jpg?quality=86&strip=all", movements: []))
    }
}
