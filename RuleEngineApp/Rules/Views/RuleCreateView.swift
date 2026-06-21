//
//  RuleCreateView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RuleCreateView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    var viewModel:
        RuleEditorViewModel

    var body: some View {

        Form {

            Section("Rule") {

                TextField(
                    "Rule Name",
                    text:
                        $viewModel.name
                )
                .accessibilityIdentifier("txtRuleName")

                Toggle(
                    "Active",
                    isOn:
                        $viewModel.isActive
                )
            }

            Section("Condition") {

                TextField(
                    "Field",
                    text:
                        $viewModel.field
                )
                .accessibilityIdentifier("txtField")

                Picker(
                    "Operator",
                    selection:
                        $viewModel.operation
                ) {

                    ForEach(
                        RuleConditionOperator
                            .allCases
                    ) {

                        Text($0.title)
                            .tag($0)
                    }
                }

                TextField(
                    "Value",
                    text:
                        $viewModel.value
                )
                .accessibilityIdentifier("txtValue")
            }

            Section("Action") {

                TextField(
                    "Action Message",
                    text:
                        $viewModel
                            .actionMessage
                )
                .accessibilityIdentifier("txtAction")
            }

            Button("Save") {

                Task {

                    await viewModel
                        .saveRule()

                    dismiss()
                }
            }
            .accessibilityIdentifier("btnSave")
        }
        .navigationTitle(
            viewModel.name.isEmpty
            ? "New Rule"
            : "Edit Rule"
        )
    }
}
