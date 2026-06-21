//
//  ContentView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 16/06/26.
//

import SwiftUI

struct RootView: View {

    @StateObject
    private var sessionVM = FBSessionViewModel()

    private let container = DependencyContainer()

    var body: some View {

        if sessionVM.isLoadingSession {
            ProgressView()
                .scaleEffect(1.5)
        } else if sessionVM.isLoggedIn {
            MainTabView()
        } else {
            SigninView(
                viewModel: FBAuthViewModel(authService: container.authService)
            )
        }
    }
}
