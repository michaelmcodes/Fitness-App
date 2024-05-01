//
//  AsyncCenterCroppedImageView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import RemoteImage

struct AsyncCenterCroppedImageView: View {
    var url: URL?
    
    var body: some View {
        if let url = url {
            RemoteImage(type: .url(url), errorView: { error in
                Text(error.localizedDescription)
            }, imageView: { image in
                image
                    .centerCropped()
            }, loadingView: {
                ZStack {
                    Color.gray.opacity(0.7)
                    ProgressView().progressViewStyle(.circular)
                    
                }
            })
        } else {
            Image("profileImagePlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
