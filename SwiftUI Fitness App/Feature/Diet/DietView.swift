//
//  DietView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import AlertToast

struct DietView: View {
    @StateObject var viewModel = DietViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("Suggested Diets")
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
                        Text(viewModel.dietType.stringValue)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    if viewModel.isLoading {
                        LoadingView()
                            .padding(.vertical, 50)
                            .frame(minHeight: proxy.size.height)
                    } else {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.diets, id: \.self) { diet in
                                DietItemView(diet: diet)
                            }
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

struct DietView_Previews: PreviewProvider {
    static var previews: some View {
        DietView()
    }
}
