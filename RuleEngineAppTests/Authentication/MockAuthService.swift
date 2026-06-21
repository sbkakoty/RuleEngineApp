//
//  MockAuthService.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 18/06/26.
//

import Foundation
@testable import RuleEngineApp

final class MockAuthService: FBAuthServiceProtocol {

    var isAuthenticated = false

    var signInCalled = false
    var registerCalled = false
    var signOutCalled = false

    func login(email: String, password: String) async throws {

        signInCalled = true
        isAuthenticated = true
    }

    func register(email: String,password: String) async throws {

        registerCalled = true
    }

    func signOut() async throws {

        signOutCalled = true
        isAuthenticated = false
    }
}
