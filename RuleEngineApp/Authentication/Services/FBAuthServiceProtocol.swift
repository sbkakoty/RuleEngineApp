//
//  FBAuthServiceProtocol.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

protocol FBAuthServiceProtocol {

    func login(email: String, password: String) async throws

    func register(email: String, password: String) async throws

    func signOut() async throws
    
    var isAuthenticated: Bool { get }
}
