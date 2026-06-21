//
//  AuthViewModelTests.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 18/06/26.
//

import XCTest
@testable import RuleEngineApp

@MainActor
final class AuthViewModelTests: XCTestCase {

    func testLoginWithEmptyEmail() async {

        let mockService = MockAuthService()

        let viewModel = FBAuthViewModel(authService: mockService)

        viewModel.email = ""
        viewModel.password = "1234567"

        await viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage,"Email is required")

        XCTAssertFalse(mockService.signInCalled)
    }
    
    func testLoginWithEmptyPassword() async {

        let mockService = MockAuthService()

        let viewModel = FBAuthViewModel(authService: mockService)

        viewModel.email = "sbkakoty@gmail.com"
        viewModel.password = ""

        await viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage, "Password is required")

        XCTAssertFalse(mockService.signInCalled)
    }

    func testLoginWithShortPassword() async {

        let mockService = MockAuthService()

        let viewModel = FBAuthViewModel(authService: mockService)

        viewModel.email = "test@test.com"
        viewModel.password = "123"

        await viewModel.login()

        XCTAssertEqual(viewModel.errorMessage,"Password must be at least 6 characters")

        XCTAssertFalse(mockService.signInCalled)
    }

    func testRegisterSuccess() async {

        let mockService = MockAuthService()

        let viewModel = FBAuthViewModel(authService: mockService)

        viewModel.email = "sbkakoty@gmail.com"
        viewModel.password = "123456"

        await viewModel.register()

        XCTAssertTrue(mockService.registerCalled)
    }

    func testLogout() async {

        let mockService = MockAuthService()

        let viewModel = FBAuthViewModel(authService: mockService)

        await viewModel.logout()

        XCTAssertTrue(mockService.signOutCalled)
    }
}
