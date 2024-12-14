//
//  ForgotPassword.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 14.12.2024.
//

import SwiftUI

struct ForgotPassword: View {
    
    @Binding var showResetView: Bool
    
    //MARK: - View Properties
    @State private var emailId: String = ""
    
    // environment properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            // back button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("Please enter your Email Id so that we can send the reset link.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // text fields
                CustomTextField(sfIcon: "at", hint: "Email Id", value: $emailId)
                
                // signUp button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    
                    // your code after the link sent
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        // showing the reset view
                        showResetView = true
                    }
                }
                .hSpacing(.center)
                .padding(.top, 20)
                
                // disabling until the data is entered
                .disableWithOpacity(emailId.isEmpty)
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
