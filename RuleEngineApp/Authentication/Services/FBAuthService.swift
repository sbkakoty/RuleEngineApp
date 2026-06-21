//
//  FBAuthService.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseAuth

final class FBAuthService: FBAuthServiceProtocol {

    var isAuthenticated: Bool {
        Auth.auth().currentUser != nil
    }
    
    func login(email: String, password: String) async throws {

        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func register(email: String, password: String) async throws {

        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
