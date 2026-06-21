//
//  RuleDisplayView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RuleDisplayView: View {

    @StateObject
    var viewModel:
        RuleListViewModel

    private let container =
        DependencyContainer()

    var body: some View {

        List {

            ForEach(
                viewModel.rules
            ) { rule in

                NavigationLink {

                    RuleCreateView(
                        viewModel:
                            RuleEditorViewModel(
                                repository:
                                    container
                                        .ruleService,
                                rule: rule
                            )
                    )

                } label: {

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text(rule.name)
                            .font(.headline)

                        Text(
                            "\(rule.condition.field) \(rule.condition.operation.title) \(rule.condition.value)"
                        )
                        .font(.caption)

                        Text(
                            rule.action.message
                        )

                        Toggle(
                            "Active",
                            isOn: Binding(
                                get: {
                                    rule.isActive
                                },
                                set: { _ in

                                    Task {

                                        await viewModel
                                            .toggleRule(
                                                rule
                                            )
                                    }
                                }
                            )
                        )
                    }
                }
            }
            .onDelete { offsets in

                Task {

                    await viewModel
                        .deleteRule(
                            at: offsets
                        )
                }
            }
        }
        .navigationTitle("Rules")
        .accessibilityIdentifier("ruleList")

        .toolbar {

            NavigationLink {

                RuleCreateView(
                    viewModel:
                        RuleEditorViewModel(
                            repository:
                                container
                                    .ruleService
                        )
                )

            } label: {

                Image(
                    systemName:
                        "plus"
                )
            }
            .accessibilityIdentifier("navCreateRule")
        }
        .task {

            await viewModel
                .loadRules()
        }
    }
}
