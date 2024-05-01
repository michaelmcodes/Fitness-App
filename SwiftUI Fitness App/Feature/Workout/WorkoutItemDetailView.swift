//
//  WorkoutItemDetailView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct WorkoutItemDetailView: View {
    var workout: Workout
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 10) {
                    ZStack {
                        AsyncCenterCroppedImageView(url: URL(string: workout.image)!)
                    }
                    .frame(height: 300)
                    .overlay(
                        BackButtonView(geometry: geometry)
                    , alignment: .top)
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text(workout.title)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                            Spacer()
                            Text(workout.duration)
                                .font(.system(size: 18))
                                .fontWeight(.light)
                            
                            
                        }
                        
                        HStack {
                            Text(workout.description)
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        if workout.movements.count == 0 {
                            Text("No movement")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding(50)
                        } else {
                            HStack{
                                Text("Exercises (\(workout.movements.count))")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding(.top)
                            ForEach(workout.movements) { movement in
                                MovementView(movement: movement)
                            }
                        }
                    }
                    .padding()
                }
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden()
            .statusBarHidden(true)
        }
    }
}

struct WorkoutItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutItemDetailView(workout: .init(title: "Push Day", duration: "1 month", description: "", image: "https://www.muscleandfitness.com/wp-content/uploads/2016/09/Bodybuilder-Working-Out-His-Upper-Body-With-Cable-Crossover-Exercise.jpg?quality=86&strip=all", movements: []))
    }
}
