//
//  GradientButton.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 13.12.2024.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15){
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.yellow, .blue], startPoint: .topLeading, endPoint: .bottom), in: .capsule)
        })
    }
}

#Preview {
    ContentView()
}
