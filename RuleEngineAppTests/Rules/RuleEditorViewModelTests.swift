//
//  RuleEditorViewModelTests.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 18/06/26.
//

import XCTest
@testable import RuleEngineApp

@MainActor
final class RuleEditorViewModelTests: XCTestCase {
    
    func testCreateRule() async throws {
        let mockRuleRepository = MockRuleRepository()
        
        let viewModel = RuleEditorViewModel(repository: mockRuleRepository)
        viewModel.name = "Expense Approval"
        viewModel.field = "amount"
        viewModel.operation = .greaterThan
        viewModel.value = "5000"
        viewModel.actionMessage = "Require Manager Approval"
        
        await viewModel.saveRule()
        
        XCTAssertTrue(
            mockRuleRepository.createCalled
        )
    }
    
    func testLoadRuleTobeEdited() async throws {
        
        let rule = Rule(id: "1", name: "Expense Approval", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "5000"), action: RuleAction(type: "approval", message: "Require Manager Approval"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        let viewModel = RuleEditorViewModel(repository: mockRuleRepository, rule: rule)
        
        XCTAssertEqual(viewModel.name, "Expense Approval")
        
        XCTAssertEqual(viewModel.field, "amount")
        
        XCTAssertEqual(viewModel.value, "5000")
    }
    
    func testUpdateRule() async throws {
        
        let rule = Rule(id: "1", name: "Expense Approval", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "5000"), action: RuleAction(type: "approval", message: "Require Manager Approval"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        let viewModel = RuleEditorViewModel(repository: mockRuleRepository, rule: rule)
        viewModel.name = "Updated Rule"
        
        await viewModel.saveRule()
        
        XCTAssertTrue(mockRuleRepository.updateCalled)
    }
    
    func testDeleteRule() async throws {
        let rule = Rule(id: "1", name: "Expense Approval", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "5000"), action: RuleAction(type: "approval", message: "Require Manager Approval"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        let viewModel = RuleListViewModel(repository: mockRuleRepository)
        
        mockRuleRepository.rules = [rule]
        viewModel.rules = [rule]
        
        await viewModel.deleteRule(at: IndexSet(integer: 0))
        
        XCTAssertTrue(mockRuleRepository.deleteCalled)
    }
}
