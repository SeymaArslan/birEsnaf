//
//  SignUp.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 14.12.2024.
//

import SwiftUI

struct SignUp: View {
    
    @Binding var showSignUp: Bool
    
    //MARK: - View Properties
    @State private var emailId: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            // back button
            Button(action: {
                showSignUp = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // text fields
                CustomTextField(sfIcon: "at", hint: "Email Id", value: $emailId)
                
                CustomTextField(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                // signUp button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    
                }
                .hSpacing(.center)
                .padding(.top, 20)
                
                // disabling until the data is entered
                .disableWithOpacity(emailId.isEmpty || password.isEmpty || fullName.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("Login") {
                    showSignUp = false
                }
                .fontWeight(.bold)
                .tint(.orange)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
