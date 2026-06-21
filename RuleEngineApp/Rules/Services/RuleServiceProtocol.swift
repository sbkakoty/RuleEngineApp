//
//  RuleServiceProtocol.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

protocol RuleServiceProtocol {

    func fetchRules() async throws -> [Rule]

    func createRule(_ rule: Rule) async throws

    func updateRule(_ rule: Rule) async throws

    func deleteRule(id: String) async throws
}
