//
//  RuleListViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RuleListViewModel:
ObservableObject {

    @Published var rules: [Rule] = []
    @Published var isLoading = false

    private let repository: RuleServiceProtocol

    init(repository: RuleServiceProtocol) {
        self.repository = repository
    }

    func loadRules() async {

        do {

            rules = try await repository.fetchRules()

        } catch {

            print(error)
        }
    }

    func deleteRule(at offsets: IndexSet) async {

        guard let index = offsets.first else { return }

        let rule = rules[index]

        guard let id = rule.id else{ return }

        do {

            try await repository.deleteRule(id: id)

            rules.remove(atOffsets: offsets)

        } catch {

            print(error)
        }
    }

    func toggleRule(_ rule: Rule) async {

        let updatedRule = Rule(id: rule.id, name: rule.name, isActive: !rule.isActive, condition: rule.condition, action: rule.action,createdAt: rule.createdAt)

        do {

            try await repository.updateRule(updatedRule)

            await loadRules()

        } catch {

            print(error)
        }
    }
}
