//
//  Home.swift
//  SwiftUI-Playstation-Tabbar
//
//  Created by Seungsub Oh on 9/14/24.
//

import SwiftUI

struct Home: View {
    @State private var activeTab: Tab = .play
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            CustomTabBar(activeTab: $activeTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.background)
                .ignoresSafeArea()
        }
        .persistentSystemOverlays(.hidden)
    }
}
