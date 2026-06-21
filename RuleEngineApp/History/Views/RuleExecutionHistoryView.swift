//
//  RuleExecutionHistoryView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RuleExecutionHistoryView: View {

    @StateObject var viewModel: RuleExecutionHistoryViewModel

    var body: some View {

        List {

            ForEach(viewModel.executions) { execution in

                VStack(alignment: .leading, spacing: 8) {

                    Text("Event Submitted")
                        .font(.headline)

                    Text(
                        eventPayloadDescription(for: execution)
                    )

                    Text("Triggered Rules")
                        .font(.headline)

                    Text(execution.triggeredRules.joined(separator: ", "))

                    Text("Timestamp")
                        .font(.headline)

                    Text(
                        execution.executedAt.formatted(
                            date: .abbreviated,
                            time: .shortened
                        )
                    )

                    Text("Execution Result")
                        .font(.headline)

                    Text(execution.triggeredRules.count > 0 ? "Success" : "No Rules Matched")
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle(
            "Execution History"
        )
        .task {

            await viewModel
                .loadExecutions()
        }
    }
    
    private func eventPayloadDescription(for execution: Execution) -> String {

        execution.eventPayload
            .map { "\($0.key): \($0.value)" }
            .joined(separator: ", ")
    }
}
