//
//  RegistrationView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 17.12.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) var dismiss // go back
    
    var body: some View {
        VStack {
            Image("logo2")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeHolder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $fullName,
                          title: "Full Name",
                          placeHolder: "Enter your name")
                
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your password",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeHolder: "Confirm your password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                print("Sign user up..")
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(Colors.blue))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
