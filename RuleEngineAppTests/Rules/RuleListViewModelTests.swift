//
//  RuleListViewModelTests.swift
//  RuleEngineAppTests
//
//  Created by Sonjoy Borkakoty on 18/06/26.
//

import XCTest
@testable import RuleEngineApp

@MainActor
final class RuleListViewModelTests: XCTestCase {
    
    func testLoadRules() async {
        let rule = Rule(id: "1", name: "Expense approval", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "5000"), action: RuleAction(type: "approval", message: "Require Manager Approval"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        mockRuleRepository.rules = [rule]
        
        let ruleListViewModel = RuleListViewModel(repository: mockRuleRepository)
        
        await ruleListViewModel.loadRules()
        
        XCTAssertTrue(
            mockRuleRepository.fetchCalled
        )
        
        XCTAssertEqual(ruleListViewModel.rules.count, 1)
    }
    
    func testCreateRule() async {
        
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
    
    func testDeleteRule() async {
        
        let rule = Rule(id: "1", name: "Test Rule", isActive: true, condition: RuleCondition(field: "amount", operation: .greaterThan, value: "100"), action: RuleAction(type: "approval", message: "Approved"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        mockRuleRepository.rules = [rule]
        
        let viewModel = RuleListViewModel(repository: mockRuleRepository)
        viewModel.rules = [rule]
        
        await viewModel.deleteRule(at: IndexSet(integer: 0))
        
        XCTAssertTrue(mockRuleRepository.deleteCalled)
    }
    
    func testToggleRule() async throws {
        
        let rule = Rule(id: "1", name: "test", isActive: true, condition: RuleCondition(field: "Expense Rule", operation: .greaterThan, value: "100"), action: RuleAction(type: "approval", message: "Approve"), createdAt: Date())
        
        let mockRuleRepository = MockRuleRepository()
        let viewModel = RuleListViewModel(repository: mockRuleRepository)
        
        await viewModel.toggleRule(rule)
        
        XCTAssertTrue(mockRuleRepository.updateCalled)
    }
}
