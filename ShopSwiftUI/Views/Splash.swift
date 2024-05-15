//
//  Splash.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 09.05.2024.
//

import SwiftUI
import FirebaseAuth

struct Splash: View {
    @State var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                if Auth.auth().currentUser != nil {
                    ContentView()
                } else {
                    Onboarding()
                }
            } else {
                Text("Brand")
                    .font(.largeTitle.bold())
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
