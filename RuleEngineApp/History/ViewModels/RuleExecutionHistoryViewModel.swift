//
//  RuleExecutionHistoryViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import Combine

@MainActor
final class RuleExecutionHistoryViewModel:
ObservableObject {

    @Published
    var executions: [Execution] = []

    @Published
    var isLoading = false

    private let repository:
        RuleExecutionHistoryServiceProtocol

    init(
        repository:
            RuleExecutionHistoryServiceProtocol
    ) {

        self.repository = repository
    }

    func loadExecutions() async {

        isLoading = true

        defer {

            isLoading = false
        }

        do {

            executions =
                try await repository
                .fetchExecutions()

        } catch {

            print(error)
        }
    }
}
