//
//  CompanyView.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 22.12.2024.
//

import SwiftUI

struct CompanyView: View {
    
    struct Company: Identifiable {
        let id = UUID()
        var name: String
    }
    
    var cookieComps = [
        Company(name: "Un"),
        Company(name: "Şeker"),
        Company(name: "Yağ")
    ]
    
    @State private var icecreamComps = [
        Company(name: "Süt"),
        Company(name: "Dondurma Şekeri"),
        Company(name: "Dondurma Makine")
    ]
    
    var body: some View {
        List {
            ForEach(cookieComps) { cookieComp in
                Text(cookieComp.name)
            }
            
            ForEach(icecreamComps) { icecreamComp in
                Text(icecreamComp.name)
            }
            
            Button("Add New Company") {
                icecreamComps.append(Company(name: "Buz"))
            }
            
            Button("Remove Company") {
                icecreamComps.remove(at: icecreamComps.count - 1)
            }
        }
    }
}

#Preview {
    CompanyView()
}
