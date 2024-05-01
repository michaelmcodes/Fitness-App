//
//  TabBarContainerView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct TabBarContainerView: View {
    @State var selectedTab: Tab = .home
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Group {
                    switch(selectedTab) {
                    case .home:
                        HomeView()
                    case .workout:
                        WorkoutView()
                    case .diet:
                        DietView()
                    case .fitness:
                        FitnessView()
                    }
                }
                .frame(maxHeight: .infinity)
                CustomTabBarView(selectedTab: $selectedTab, bottomPadding: geometry.safeAreaInsets.bottom)
            }
            .if(selectedTab == .fitness) {view in
                view.background(.black.opacity(0.9))
            }
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden()
        }
    }
}
