//
//  Extensions.swift
//  SwiftUI-Playstation-Tabbar
//
//  Created by Seungsub Oh on 9/14/24.
//

import SwiftUI

extension View {
    var safeArea: UIEdgeInsets {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let safeArea = windowScene.windows.first?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    func glow(_ color: Color, radius: CGFloat) -> some View {
        self.shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
            .shadow(color: color, radius: radius / 2.5)
    }
}
