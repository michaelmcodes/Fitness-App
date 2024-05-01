//
//  BottomSheet.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct BottomSheet: View {
    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .padding(.bottom, 42)
                    .transition(.move(edge: .bottom))
                    .background(
                        Color(uiColor: .white)
                    )
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .overlay{
                        VStack {
                            Image(systemName: "chevron.compact.down")
                                .onTapGesture {
                                    isShowing.toggle()
                                }
                                .font(.system(size: 40))
                            Spacer()
                        }
                        .padding()
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
        
    }
}
