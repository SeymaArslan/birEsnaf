//
//  ForgotPassowrdView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 14.12.2024.
//

import SwiftUI

struct PasswordResetView: View {
    //MARK: - View Properties
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    // environment properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            // back button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
                // text fields
                CustomTextField(sfIcon: "lock", hint: "Password", value: $password)
                CustomTextField(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                    .padding(.top, 5)
                
                // signUp button
                GradientButton(title: "Send Link", icon: "arrow.right") {

                }
                .hSpacing(.center)
                .padding(.top, 20)
                
                // disabling until the data is entered
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        
        // since this is going to be a Sheet.
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
