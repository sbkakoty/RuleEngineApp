//
//  RuleExecutionServiceProtocol.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

protocol RuleExecutionServiceProtocol {

    func execute(event: [String: Any], rules: [Rule]) -> ExecutionResult
}
