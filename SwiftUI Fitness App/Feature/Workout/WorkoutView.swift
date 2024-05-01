//
//  WorkoutView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import AlertToast

struct WorkoutView: View {
    @StateObject var viewModel = WorkoutViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("Suggested Workouts")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        Text("Based on ")
                            .font(.system(size: 18))
                            .fontWeight(.thin)
                        +
                        Text(viewModel.exerciseType.stringValue)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    if viewModel.isLoading {
                        LoadingView()
                            .padding(.vertical, 50).frame(minHeight: proxy.size.height)
                        
                    } else {
                        ForEach(viewModel.workouts, id: \.self) { workout in
                            WorkoutItemView(workout: workout)
                        }
                    }
                    
                }
                .padding()
            }
            .toast(isPresenting: $viewModel.showError){
                AlertToast(type: .error(.red), title: viewModel.error)
            }
            .padding(.top, 1)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
