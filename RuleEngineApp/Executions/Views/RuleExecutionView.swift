//
//  RuleExecutionView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RuleExecutionView: View {

    @StateObject
    var viewModel:
        RuleExecutionViewModel

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 16
            ) {

                Text("Event Payload")
                    .font(.headline)

                TextEditor(
                    text:
                        $viewModel
                        .jsonPayload
                )
                .frame(height: 150)
                .border(.gray)
                .accessibilityIdentifier("textEditorPayload")

                Button {

                    Task {

                        await viewModel
                            .executeEvent()
                    }

                } label: {

                    Text(
                        "Execute Rules"
                    )
                    .frame(
                        maxWidth:
                            .infinity
                    )
                }
                .accessibilityIdentifier("btnExecute")
                

                if let result =
                    viewModel.result {

                    VStack(
                        alignment:
                            .leading,
                        spacing: 12
                    ) {

                        Text(
                            "Triggered Rules"
                        )
                        .font(.headline)

                        ForEach(
                            result
                            .triggeredRules,
                            id: \.self
                        ) {

                            Text("• \($0)")
                        }

                        Text(
                            "Actions"
                        )
                        .font(.headline)

                        ForEach(
                            result.actions,
                            id: \.self
                        ) {

                            Text("• \($0)")
                        }
                    }
                }

                if !viewModel
                    .errorMessage
                    .isEmpty {

                    Text(
                        viewModel
                            .errorMessage
                    )
                    .foregroundColor(
                        .red
                    )
                }
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle(
            "Execute Event"
        )
        .accessibilityIdentifier("scrollViewExecute")
    }
}

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
