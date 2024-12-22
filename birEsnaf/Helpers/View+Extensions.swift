//
//  View+Extensions.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 12.12.2024.
//

import SwiftUI

// custom swift uı view extensions
extension View {
    //MARK: - View alignments
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
    
//    func setBackgroundColor(_ color: Color) -> some View {
//        self.background(color.ignoresSafeArea())
//    }
}

extension Color {
    static let customBackground = Color("CustomBackground") // Assets'te tanımlı bir renk
    static let bground = Color("backgroundColor")
    static let customText = Color("CustomText") // Özel yazı rengi
}
