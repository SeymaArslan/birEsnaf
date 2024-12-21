//
//  LoginView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 17.12.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                // image
                Image("logo2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeHolder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                // sign in button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(Colors.blue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 40)
                
                Spacer()
                
                // sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            .foregroundColor(Color(Colors.blue))
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundColor(Color(Colors.blue))
                    }
                    .font(.system(size: 14))
                }

            }
        }
    }
    
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
