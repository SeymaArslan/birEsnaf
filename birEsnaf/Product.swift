//
//  Product.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 23.12.2024.
//

import Foundation

struct ProductData: Codable {
    let product: [Product]?
    let count: String?
    let success: Int?
}

struct Product: Identifiable, Codable, Equatable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.prodName == rhs.prodName
    }
    
    var id: String { prodId ?? UUID().uuidString }
    let prodId: String?
    let userMail: String?
    let prodName: String?
    let prodTotal: String?
    let prodPrice: String?
    let count: String?
}

extension User {
    static var MOCK_PRODUCT = Product(prodId: NSUUID().uuidString, userMail: "test@test.com", prodName: "Icecream", prodTotal: "30", prodPrice: "15.0", count: nil)
    

}
