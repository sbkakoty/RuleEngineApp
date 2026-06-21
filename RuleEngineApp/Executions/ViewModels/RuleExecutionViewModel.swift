//
//  RuleExecutionViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import Combine

@MainActor
final class RuleExecutionViewModel: ObservableObject {

    @Published var jsonPayload = ""

    @Published var result: ExecutionResult?

    @Published var errorMessage = ""

    @Published var isLoading = false

    private let ruleService: RuleServiceProtocol

    private let ruleExecution: RuleExecutionServiceProtocol

    private let executionHistoryRepository: RuleExecutionHistoryServiceProtocol

    init(
        ruleService: RuleServiceProtocol,
        ruleExecution: RuleExecutionServiceProtocol,
        executionHistoryRepository: RuleExecutionHistoryServiceProtocol
    ) {
        self.ruleService = ruleService
        self.ruleExecution = ruleExecution
        self.executionHistoryRepository = executionHistoryRepository
    }

    func executeEvent() async {

        errorMessage = ""
        
        guard !jsonPayload.isEmpty else {
            errorMessage = "Event Payload is required"
            return
        }
        
        isLoading = true

        defer {
            isLoading = false
        }

        do {

            let payload = try parsePayload()

            let rules = try await ruleService.fetchRules()

            let executionResult = ruleExecution.execute(event: payload, rules: rules)

            result = executionResult

            let execution = Execution(
                id: nil,
                eventPayload:
                    payload.mapValues {
                        "\($0)"
                },
                triggeredRules: executionResult.triggeredRules,
                actions: executionResult.actions,
                executedAt: Date(),
                success: true
            )

            try await executionHistoryRepository.saveExecution(execution)

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    private func parsePayload() throws -> [String: Any] {

        guard let data = jsonPayload.data(using: .utf8) else {
            throw NSError(domain: "Invalid UTF8", code: -1)
        }

        let jsonObject = try JSONSerialization.jsonObject(with: data)

        guard let json = jsonObject as? [String: Any] else {
            throw NSError(domain: "JSON is not a dictionary", code: -1)
        }

        return json
    }
}
