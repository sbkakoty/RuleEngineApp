//
//  RuleExecutionHistoryServiceProtocol.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

protocol RuleExecutionHistoryServiceProtocol {

    func saveExecution(_ execution: Execution) async throws

    func fetchExecutions() async throws -> [Execution]
}
