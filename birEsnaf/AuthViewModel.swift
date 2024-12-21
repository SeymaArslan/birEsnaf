//
//  AuthViewModel.swift
//  birEsnaf
//
//  Created by Seyma Arslan on 18.12.2024.
//  

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

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
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()  // kullanıcıyı getirmesi için
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
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
        do {
            try Auth.auth().signOut()  // signs out user on backend
            self.userSession = nil  // wipes out user session and takes us back to login screen
            self.currentUser = nil  // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
//        print("DEBUG: Current user is \(self.currentUser)")
    }
}
