//
//  DependencyContainer.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

final class DependencyContainer {

    lazy var authService: FBAuthServiceProtocol = FBAuthService()
    lazy var ruleService: RuleServiceProtocol = RuleService()
    lazy var ruleExecution: RuleExecutionServiceProtocol = RuleExecutionService()
    lazy var executionHistoryRepository: RuleExecutionHistoryServiceProtocol = RuleExecutionHistoryService()
}
