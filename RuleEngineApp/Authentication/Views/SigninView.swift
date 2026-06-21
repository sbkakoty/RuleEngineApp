//
//  SigninView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct SigninView: View {
    @StateObject var viewModel: FBAuthViewModel

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                SigninFormContent(viewModel: viewModel)
                    .navigationTitle("Login")
            }
        } else {
            NavigationView {
                SigninFormContent(viewModel: viewModel)
                    .navigationTitle("Login")
            }
        }
    }
}

struct SigninFormContent: View {
    
    @ObservedObject var viewModel: FBAuthViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Rule Engine")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .accessibilityIdentifier("txtEmail")
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .accessibilityIdentifier("txtPassword")
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            
            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("btnLogin")
            
            NavigationLink {
                RegisterView(viewModel: viewModel)
            } label: {
                Text("Create Account")
            }
            
            Spacer()
        }
        .padding()
    }
}
