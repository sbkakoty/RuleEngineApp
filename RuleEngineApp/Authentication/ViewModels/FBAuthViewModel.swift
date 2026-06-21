//
//  FBAuthViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import Combine

// Swift guarantees that all methods and property mutations inside the ViewModel execute on the Main Actor (main thread).
@MainActor
final class FBAuthViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage = ""

    private let authService: FBAuthServiceProtocol

    init(authService: FBAuthServiceProtocol) {
        self.authService = authService
    }

    func login() async {

        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }

        guard password.count >= 6 else {

            errorMessage =
                "Password must be at least 6 characters"

            return
        }

        
        isLoading = true

        defer {
            isLoading = false
        }

        do {

            try await authService.login(email: email, password: password)

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    func register() async {

        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }

        isLoading = true

        defer {
            isLoading = false
        }

        do {

            try await authService.register(email: email, password: password)

        } catch {

            errorMessage = error.localizedDescription
        }
    }
    
    func logout() async {

        do {

            try await authService.signOut()

        } catch {

            print("Logout failed:", error.localizedDescription)
        }
    }
}
