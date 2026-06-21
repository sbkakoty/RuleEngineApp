//
//  SettingsView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var viewModel: FBAuthViewModel

    var body: some View {

        Form {

            Section {

                Button(
                    role: .destructive
                ) {
                    Task {
                        await viewModel.logout()
                    }

                } label: {

                    HStack {

                        Image(
                            systemName:
                                "rectangle.portrait.and.arrow.right"
                        )

                        Text(
                            "Logout"
                        )
                    }
                }
                .accessibilityIdentifier("btnLogout")

            } header: {

                Text("Account")
            }
        }
        .navigationTitle(
            "Settings"
        )
    }
}
