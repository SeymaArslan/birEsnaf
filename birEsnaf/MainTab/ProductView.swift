//
//  ProductsView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 22.12.2024.
//

import SwiftUI

struct ProductView: View {
    
    var productList = [
        Product(prodId: NSUUID().uuidString, userMail: "test@test.com", prodName: "Icecream", prodTotal: "30", prodPrice: "15.0", count: nil),
        Product(prodId: NSUUID().uuidString, userMail: "test@test.com", prodName: "Cheesecake", prodTotal: "30", prodPrice: "15.0", count: nil),
        Product(prodId: NSUUID().uuidString, userMail: "test@test.com", prodName: "Baklava", prodTotal: "30", prodPrice: "15.0", count: nil)
    ]
    
    var body: some View {
        VStack {
            
            List (productList) { product in
                Text(product.prodName!)
            }

            
        }
    }
}

#Preview {
    ProductView()
}
