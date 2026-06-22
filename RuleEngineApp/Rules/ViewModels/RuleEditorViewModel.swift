//
//  RuleEditorViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import Combine

@MainActor
final class RuleEditorViewModel: ObservableObject {

    @Published var name = ""
    @Published var field = ""
    @Published var operation: RuleConditionOperator = .equal
    @Published var value = ""
    @Published var actionMessage = ""
    @Published var isActive = true

    private let repository: RuleServiceProtocol

    private var editingRule: Rule?

    init(repository: RuleServiceProtocol, rule: Rule? = nil) {

        self.repository = repository
        self.editingRule = rule

        guard let rule else{ return }

        name = rule.name
        field = rule.condition.field
        operation = rule.condition.operation
        value = rule.condition.value
        actionMessage = rule.action.message
        isActive = rule.isActive
    }

    func saveRule() async {

        let rule = Rule(
            id: editingRule?.id,
            name: name,
            isActive: isActive,
            condition:
                RuleCondition(
                    field: field,
                    operation: operation,
                    value: value
                ),
            action:
                RuleAction(
                    type: "generic",
                    message: actionMessage
                ),
            createdAt: editingRule?.createdAt ?? Date())

        do {
            if editingRule == nil {
                try await repository.createRule(rule)
            } else {
                try await repository.updateRule(rule)
            }
        } catch {
            print(error)
        }
    }
}
