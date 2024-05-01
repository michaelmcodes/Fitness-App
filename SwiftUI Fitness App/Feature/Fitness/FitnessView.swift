//
//  FitnessView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI
import SwiftUIGIF

struct FitnessView: View {
    @State private var imageData: Data? = nil
    @State var currentDate = Date.now
    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
    @State private var currentTip = 1
    @State private var currentIndex = Int.random(in: 0..<Constants.fitnessTips.count)
    
    @State private var tips = Constants.fitnessTips
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let data = imageData {
                    GIFImage(data: data)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                    
                    VStack {
                        
                        HStack {
                            Text("Tips")
                                .foregroundColor(.white)
                                .font(.system(size: 34))
                                .fontWeight(.heavy)
                                .padding(.vertical)
                                .padding(.horizontal)
                            Spacer()
                        }
                        VStack(spacing: 10) {
                            HStack {
                                Text("Tip #")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                + Text("\(currentTip)")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Text(tips[currentIndex])
                                    .font(.system(size: 28))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(.white.opacity(0.3))
                        .cornerRadius(CGFloat(Constants.globalRadius))
                        .padding()
                        Spacer()
                    }
                    .padding()
                    .frame(height: geometry.size.height)
                } else {
                    ZStack {
                        Color.black.opacity(0.7)
                        ProgressView().progressViewStyle(.circular)
                            .scaleEffect(2)
                            .tint(.white)
                    }
                    .onAppear(perform: loadData)
                }
                
                
            }
            .onReceive(timer) { input in
                withAnimation(.easeInOut(duration: 0.6)) {
                    if currentTip != Constants.fitnessTips.count {
                        tips.remove(at: currentIndex)
                        currentTip += 1
                        currentIndex = Int.random(in: 0..<tips.count)
                    } else {
                        timer.upstream.connect().cancel()
                    }
                }
            }
            .statusBarHidden()
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func loadData() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://i.gifer.com/M1fa.gif")!) { data, response, error in
            imageData = data
        }
        task.resume()
    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView()
    }
}
