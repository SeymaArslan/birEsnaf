//
//  Login.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 12.12.2024.
//

import SwiftUI

struct Login: View {
    //MARK: - View Properties
    @State private var emailId: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // text fields
                CustomTextField(sfIcon: "at", hint: "Email Id", value: $emailId)
                
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Button("Forgot Password?") {
                    
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.orange)
                .hSpacing(.trailing) // 6 24
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
