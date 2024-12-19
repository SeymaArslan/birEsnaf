//
//  AuthViewModel.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 18.12.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor // sebebi tüm kullanıcı arayüzü güncellemelerini ana iş parçacığında yayınlamamız gerektiğidir bu varsayılan olarak tüm asenkron ağ oluşturma işlemi arka plan iş parçacığında gerçekleşir ve kullanıcı arayüzü değişikliklerimizi ana iş parçacığında yayınladığımızdan emin olmak isteriz ve bu MainActor bildiriminin orada yaptığı şey budur.
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("sign in")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print("DEBUG: Faieled to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: Current user is \(self.currentUser)")
    }
}
