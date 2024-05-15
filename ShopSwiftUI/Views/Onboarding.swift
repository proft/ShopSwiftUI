//
//  Onboarding.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 09.05.2024.
//

import SwiftUI

struct Onboarding: View {
    @State private var isActive = false
    @State private var isExpanded = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        NavigationStack {
            if isActive {
                SignIn()
            } else {
                ZStack(alignment: .top) {
                    VStack {
                        Spacer()
                        Circle()
                            .fill(
                                RadialGradient(colors: [.red, .clear, .clear, .clear], center: .center, startRadius: 0, endRadius: UIScreen.main.bounds.width)
                            )
                            .scaleEffect(isExpanded ? 20 : 2)
                            .padding(.bottom, -(UIScreen.main.bounds.width / 2))
                        
                    }
                    .frame(maxHeight: .infinity)
                    .zIndex(isExpanded ? 2 : 0)
                    
                    VStack(spacing: 15) {
                        Spacer()
                        
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Start Journey\nwith us")
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        
                        Text("Innovative decisions already here")
                            .multilineTextAlignment(.center)
                            .opacity(0.6)
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "chevron.up")
                            
                            Text("Get Started")
                                .padding(.top)
                        }
                        .fontWeight(.medium)
                    }
                    .opacity(isExpanded ? 0 : 1)
                    .offset(offset)
                    
                }
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            if value.translation.height < 50 {
                                withAnimation(.easeInOut(duration: 2)) {
                                    offset = value.translation
                                    isExpanded = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        isActive.toggle()
                                    }
                                }
                            }
                        })
                )
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(colors: [Color.white, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                )
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    Onboarding()
}
