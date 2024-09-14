//
//  CustomTabBar.swift
//  SwiftUI-Playstation-Tabbar
//
//  Created by Seungsub Oh on 9/14/24.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var activeTab: Tab
    
    var bottomPadding: CGFloat {
        safeArea.bottom == 0 ? 15 : safeArea.bottom
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Image(systemName: tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .offset(y: offset(tab))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.interpolatingSpring) {
                                activeTab = tab
                            }
                        }
                        .frame(maxWidth: .infinity)
                }
                .foregroundStyle(Color(uiColor: .label))
            }
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
        .padding(
            .bottom,
            bottomPadding
        )
        .background {
            ZStack {
                TabBarTopCurve()
                    .stroke(.white, lineWidth: 0.5)
                    .blur(radius: 0.5)
                    .padding(.horizontal, -10)
                
                TabBarTopCurve()
                    .fill(
                        Color.gray.opacity(0.5).gradient
                    )
            }
        }
        .overlay {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxedWidth = width * 5
                let height = rect.height
                let radius = maxedWidth / 2
                
                Circle()
                    .fill(.gray.opacity(0.1).gradient)
                    .frame(width: maxedWidth, height: maxedWidth)
                    .frame(width: width)
                    .overlay {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45, height: 4)
                            .glow(.white.opacity(0.5), radius: 50)
                            .glow(.purple.opacity(0.7), radius: 30)
                            .offset(y: -1.5)
                            .offset(
                                y: -maxedWidth / 2
                            )
                            .rotationEffect(
                                .degrees(
                                    rotationAmount(width: width, radius: radius)
                                )
                            )
                    }
                    .offset(y: height / 2.1)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func rotationAmount(width: CGFloat, radius: CGFloat) -> CGFloat {
        let totalDegrees = atan(width / radius) * 180 / .pi
        let degreePerItem = totalDegrees / Tab.count
        let offset = Int(Tab.count) % 2 == 0 ? floor(Tab.count / 2) - 0.5 : floor(Tab.count / 2)
        return degreePerItem * (activeTab.index - offset)
    }
    
    // OFfset based on tab position
    func offset(_ tab: Tab) -> CGFloat {
        let totalIndices = Tab.count
        let currentIndex = tab.index
        let progress = currentIndex / totalIndices
        
        return progress < 0.5 ? (currentIndex * -10) : (totalIndices - currentIndex - 1) * -10
    }
}

struct TabBarTopCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            let minWidth = width / 2
            
            path.move(to: .init(x: 0, y: 5))
            path.addCurve(
                to: .init(x: minWidth, y: -20),
                control1: .init(x: minWidth / 2, y: -20),
                control2: .init(x: minWidth, y: -20)
            )
            path.addCurve(
                to: .init(x: width, y: 5),
                control1: .init(x: minWidth + (minWidth / 2), y: -20),
                control2: .init(x: width, y: 5)
            )
            
            path.addLine(to: .init(x: width, y: height))
            path.addLine(to: .init(x: 0, y: height))
            path.closeSubpath()
        }
    }
}

#Preview {
    ContentView()
}
