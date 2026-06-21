//
//  RuleExecutionHistoryView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RuleExecutionHistoryView: View {

    @StateObject
    var viewModel:
        RuleExecutionHistoryViewModel

    var body: some View {

        List {

            ForEach(
                viewModel.executions
            ) { execution in

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {

                    Text(
                        execution
                            .executedAt,
                        style: .date
                    )
                    .font(.headline)

                    Text(
                        "Triggered Rules"
                    )

                    ForEach(
                        execution
                            .triggeredRules,
                        id: \.self
                    ) {

                        Text("• \($0)")
                    }

                    Text("Actions")

                    ForEach(
                        execution.actions,
                        id: \.self
                    ) {

                        Text("• \($0)")
                    }
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
}
