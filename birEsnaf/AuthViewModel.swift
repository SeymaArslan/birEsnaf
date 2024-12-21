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

protocol ResendMailProtocol {
    var mailIsEmpty: Bool { get }
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
    
    func isUserVerified() async -> Bool {
        guard let user = Auth.auth().currentUser else {
            return false
        }
        
        do {
            try await user.reload()
            return user.isEmailVerified
        } catch {
            print("DEBUG: Failed to reload user with error \(error.localizedDescription)")
            return false
        }
    }
    
    func sendEmailVerification() async -> String? {
//        guard let user = Auth.auth().currentUser else {
//            return "User is not logged in."
//        }
        
        if  ((Auth.auth().currentUser?.isEmailVerified) != nil) {
            return "Your email is already verified."
        }
        
        do {
            try await  Auth.auth().currentUser?.sendEmailVerification()
            print("DEBUG: Verification email sent successfully")
            return "Verification email sent again. Please check your inbox."
        } catch {
            print("DEBUG: Failed to send verification email with error \(error.localizedDescription)")
            return "Failed to resend verification email."
        }
    }

//    func sendEmailVerification() async {
//        guard let user = Auth.auth().currentUser, !user.isEmailVerified else {
//            print("DEBUG: User is already verified or not logged in.")
//            return
//        }
//        
//        do {
//            try await user.sendEmailVerification()
//            print("DEBUG: Verification email sent successfully")
//        } catch {
//            print("DEBUG: Failed to send verification email with error \(error.localizedDescription)")
//        }
//    }
    
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
            
//            try await signOut()
            
//            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await sendEmailVerification()
//            await fetchUser()
            try signOut()
        } catch {
            print("DEBUG: Faieled to create user with error \(error.localizedDescription)")
            throw error
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
        guard let currentUser = Auth.auth().currentUser else { return }
        
        if currentUser.isEmailVerified {
            let uid = currentUser.uid
            guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
            self.currentUser = try? snapshot.data(as: User.self)
            self.userSession = currentUser
        } else {
            try? signOut()
        }
        
    }
}

