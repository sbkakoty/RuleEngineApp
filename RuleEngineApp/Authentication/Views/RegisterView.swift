//
//  RegisterView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct RegisterView: View {

    @ObservedObject var viewModel: FBAuthViewModel

    var body: some View {

        VStack(spacing: 24) {
            Spacer()
            Text("Create Account")
                .font(.title)
                .bold()
            TextField(
                "Email",
                text: $viewModel.email
            )
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            SecureField(
                "Password",
                text: $viewModel.password
            )
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }

            Button {
                Task {
                    await viewModel.register()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
    }
}
