//
//  MainTabView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 22.12.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        ZStack {
            Color.bground
                .edgesIgnoringSafeArea(.all)
            TabView {
                ProductView()
                    .tabItem {
                        Label("Products", systemImage: "cart.fill")
                    }
                
                CompanyView()
                    .tabItem {
                        Label("Companies", systemImage: "list.bullet")
                    }
                
                ShopView()
                    .tabItem {
                        Label("Shopping", systemImage: "bag.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "gearshape.fill")
                    }
            }
            .accentColor(Color(Colors.blue))
        }
    }
}

#Preview {
    MainTabView()
}
