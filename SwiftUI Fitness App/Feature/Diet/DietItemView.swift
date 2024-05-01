//
//  DietItemView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import XNavigation

struct DietItemView: View {
    @EnvironmentObject var navigation: Navigation
    var diet: Diet
    
    var body: some View {
        Button {
            navigation.pushView(DietItemDetailView(diet: diet), animated: true)
        } label: {
            ZStack {
                AsyncCenterCroppedImageView(url: URL(string: diet.image)!)
            }
            .frame(height: 140)
            .cornerRadius(CGFloat(Constants.globalRadius))
            .overlay(
                VStack {
                    Text(diet.title)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .lineLimit(2)
                    
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.black.opacity(0.3))
                    .cornerRadius(CGFloat(Constants.globalRadius), corners: [.bottomLeft, .bottomRight])
                
                , alignment: .bottom)
            
        }
    }
}

struct DietItemView_Previews: PreviewProvider {
    static var previews: some View {
        DietItemView(diet: Diet.dummyData[0])
    }
}
