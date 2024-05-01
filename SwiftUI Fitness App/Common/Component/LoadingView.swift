//
//  LoadingView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.black)
            Text("Loading...")
                .font(.system(size: 24))
                .fontWeight(.medium)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
