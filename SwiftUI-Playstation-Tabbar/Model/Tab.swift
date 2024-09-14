//
//  Tab.swift
//  SwiftUI-Playstation-Tabbar
//
//  Created by Seungsub Oh on 9/14/24.
//

import Foundation

enum Tab: String, CaseIterable {
    case play = "gamecontroller",
         explore = "location.viewfinder",
         store = "storefront",
         library = "books.vertical",
         search = "magnifyingglass"
    
    var index: CGFloat {
        return CGFloat(Tab.allCases.firstIndex(of: self) ?? 0)
    }
    
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
}
