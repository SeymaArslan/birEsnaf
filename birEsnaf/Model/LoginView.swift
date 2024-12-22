//
//  LoginView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 17.12.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bground
                    .edgesIgnoringSafeArea(.all)
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
                            do {
                                try await viewModel.signIn(withEmail: email, password: password)
                                if !(await viewModel.isUserVerified()) {
                                    alertTitle = "Email Verification"
                                    alertMessage = "Your email is not verified. Please check your inbox."
                                    showAlert = true
                                    try await viewModel.signOut()
                                }
                            } catch {
                                alertTitle = "Login Failed"
                                alertMessage = "Login failed. Please check your credentials."
                                showAlert = true
                            }
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
                    
                    HStack {
                        Button {
                            Task {
                                // Parola Sıfırlama İşlemi
                                let message = await viewModel.resetPassword(email: email)
                                alertTitle = "Password Reset"
                                alertMessage = message
                                showAlert = true
                            }
                        } label: {
                            HStack {
                                Text("Forgot Password?")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .tint(Color(Colors.blue))
                                    .opacity(mailIsEmpty ? 1.0 : 0.5)
                                    .disabled(!mailIsEmpty)
                                    .hSpacing(.centerLastTextBaseline)
                            }
                        }
                        
                        Button {
                            Task {
                                if let message = await viewModel.sendEmailVerification() {
                                    alertTitle = "Email Verification"
                                    alertMessage = message
                                }
                                showAlert = true
                            }
                        } label: {
                            HStack {
                                Text("Resend Email Verification")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .tint(Color(Colors.blue))
                                    .opacity(mailIsEmpty ? 1.0 : 0.5)
                                    .disabled(!mailIsEmpty)
                                    .hSpacing(.centerLastTextBaseline)
                            }
                        }
                    }
                    .padding(.leading, -30)
                    .padding(.top, 10)
                    
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            } // zstack
        } // navstack
    }
}

extension LoginView: AuthenticationFormProtocol, ResendMailProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    var mailIsEmpty: Bool {
        return !email.isEmpty
        && email.contains("@")
    }
}

#Preview {
    LoginView()
}
