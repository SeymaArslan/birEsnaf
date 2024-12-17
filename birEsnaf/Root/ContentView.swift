//
//  ContentView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 12.12.2024.
//

import SwiftUI

struct ContentView: View {
    // View Properties
    @State private var showSignUp: Bool = false
    var body: some View {
        NavigationStack {
            Login(showSignUp: $showSignUp)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUp(showSignUp: $showSignUp)
                }
        }
        .overlay {
            if #available(iOS 17, *) {
                CircleView()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignUp)
            } else {
                CircleView()
                    .animation(.easeInOut(duration: 0.3), value: showSignUp)
            }
        }
    }
    
    // moving blurred background
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.yellow, .teal, .blue], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
        // moving when the signup pages loads/dismisses
            .offset(x: showSignUp ? 60 : -60, y: -60)
            .blur(radius: 15)
            .hSpacing(showSignUp ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    ContentView()
}
