//
//  Login.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 12.12.2024.
//

import SwiftUI

struct Login: View {
    
    @Binding var showSignUp: Bool
    
    //MARK: - View Properties
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    // reset password view (with new password and confirmration password view
    @State private var showResetView: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            Image("logo2")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .padding(.vertical, 32)
                
            
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
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.orange)
                .hSpacing(.trailing)
                
                // login button
                GradientButton(title: "Login", icon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                
                // disabling until the data is entered
                .disableWithOpacity(emailId.isEmpty || password.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("SignUp") {
                    showSignUp.toggle()
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
        
        // asking email id for sending reset link
        .sheet(isPresented: $showForgotPasswordView, content: {
            if #available(iOS 16.4, *) {
                // since I wanted a custom sheet corner radius
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        })
        
        // reseting new password
        .sheet(isPresented: $showResetView, content: {
            if #available(iOS 16.4, *) {
                // since I wanted a custom sheet corner radius
                PasswordResetView()
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            } else {
                PasswordResetView()
                    .presentationDetents([.height(350)])
            }
        })
    }
}

#Preview {
    ContentView()
}
