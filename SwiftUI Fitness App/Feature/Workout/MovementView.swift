//
//  MovementView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct MovementView: View {
    var movement: Movement
    
    var body: some View {
        HStack {
            VStack(spacing: 6) {
                HStack{
                    Text(movement.title)
                        .font(.system(size: 19))
                        .fontWeight(.heavy)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Text(movement.target)
                        .font(.system(size: 16))
                        .fontWeight(.light)
                    Spacer()
                }
                HStack {
                    Text(movement.quantity)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Spacer()
                }
                
            }
            Spacer()
            AsyncCenterCroppedImageView(url: URL(string: movement.image)!)
                .frame(height: 95)
                .cornerRadius(CGFloat(Constants.globalRadius))
                .shadow(radius: 1)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 100)
        .padding()
        .background(.white)
        .cornerRadius(CGFloat(Constants.globalRadius))
        .shadow(radius: 6)
        .padding(.vertical, 8)
    }
}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView(movement: .init(title: "Cable Crossovers", target: "Lower chest", quantity: "4x10", image: "https://cdn.shopify.com/s/files/1/0554/1704/5132/articles/cable-crossover-exercise.jpg?v=1678169934"))
    }
}
