//
//  RuleEngineViewModelTests.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 19/06/26.
//

import XCTest
@testable import RuleEngineApp

@MainActor
final class RuleEngineViewModelTests: XCTestCase {
    
    func testExecute() async throws {
        
        let rule = Rule(id: "1", name: "Expense Approval", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "5000"), action: RuleAction(type: "approval", message: "Require Manager Approval"), createdAt: Date())
        
        let event: [String: Any] = ["amount" : 7000]
        
        let mockRuleEngineService = RuleExecutionService()
        let result = mockRuleEngineService.evaluate(rule: rule, event: event)
        
        XCTAssertTrue(result)
    }
}

