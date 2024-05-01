//
//  CustomTabBarView.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selectedTab: Tab
    var bottomPadding: CGFloat
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(selectedTab == .fitness ? .black : .white)
                .if(selectedTab != .fitness) { view in
                    view
                        .shadow(color: .gray.opacity(0.4), radius: 20, x: 0, y: 20)
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: -4)
                }
            
            if selectedTab == .fitness {
                
                Color.black
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                
            } else {

                Color.white
                    .cornerRadius(30, corners: [.topLeft, .topRight])

            }
            
            TabsLayoutView(selectedTab: $selectedTab)
                .padding(.horizontal)
                .padding(.bottom, bottomPadding)
        }
        .frame(height: 70, alignment: .center)
        
    }
}

fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .frame(width: 65, height: 65, alignment: .center)
                
                Spacer(minLength: 0)
            }
        }
    }
    
    
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(selectedTab == .fitness ? .white : .black)
                            .background {
                                Circle()
                                    .stroke(lineWidth: 15)
                                    .fill(selectedTab == .fitness ? .white : .black)
                            }
                            .offset(y: -20)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                        
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? ( selectedTab != .fitness ? .white : .black ) : .gray)
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .offset(y: isSelected ? -20 : 0)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selectedTab: .constant(.home), bottomPadding: CGFloat(20))
            .padding(.horizontal)
    }
}

enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, workout, diet, fitness
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .workout:
            return "dumbbell.fill"
        case .diet:
            return "fork.knife"
        case .fitness:
            return "doc.text.image.fill"
        }
    }
}

