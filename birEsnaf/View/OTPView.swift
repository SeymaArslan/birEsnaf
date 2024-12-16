//
//  OTPView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 14.12.2024.
//

import SwiftUI

struct OTPView: View {
    
    @Binding var otpText: String
    
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
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("An 6 digit code has been sent to your Email Id.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // signUp button
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    

                }
                .hSpacing(.center)
                .padding(.top, 20)
                
                // disabling until the data is entered
                .disableWithOpacity(otpText.isEmpty)
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
