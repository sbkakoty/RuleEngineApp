//
//  MockRuleEngineService.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 18/06/26.
//

import Foundation
@testable import RuleEngineApp

final class MockRuleRepository: RuleServiceProtocol {
    
    var rules: [Rule] = []
    var fetchCalled = false
    var createCalled = false
    var updateCalled = false
    var deleteCalled = false
    
    func fetchRules() async throws -> [Rule] {
        fetchCalled = true
        
        return rules
    }
    
    func createRule(_ rule: Rule) async throws {
        createCalled = true
        
        rules.append(rule)
    }
    
    func updateRule(_ rule: Rule) async throws {
        updateCalled = true
    }
    
    func deleteRule(id: String) async throws {
        deleteCalled = true
    }
    
    func testToggleRule(_ rule: Rule) async throws {
        updateCalled = true
    }
}
