//
//  ContentView.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 09.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            
            Text("Search view")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)

            Text("Cart view")
                .tabItem {
                    Image(systemName: "bag")
                    Text("Cart")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)

            Text("Profile view")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThickMaterial, for: .tabBar)

        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
}
