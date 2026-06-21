//
//  MainTabView.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import SwiftUI

struct MainTabView: View {

    private let container = DependencyContainer()

    var body: some View {

        TabView {

            rulesTab
                .tabItem {
                    Label("Rules", systemImage: "list.bullet.rectangle")
                }

            executeTab
                .tabItem {
                    Label("Execute", systemImage: "play.circle")
                }

            historyTab
                .tabItem {
                    Label(
                        "History",
                        systemImage:
                            "clock.arrow.circlepath"
                    )
                }
            
            settingsTab
                .tabItem {
                Label(
                    "Settings",
                    systemImage: "gear"
                )
            }
        }
    }

    @ViewBuilder
    private var rulesTab: some View {

        if #available(iOS 16.0, *) {

            NavigationStack {

                RuleDisplayView(
                    viewModel:
                        RuleListViewModel(
                            repository:
                                container
                                    .ruleService
                        )
                )
            }

        } else {

            NavigationView {

                RuleDisplayView(
                    viewModel:
                        RuleListViewModel(
                            repository:
                                container
                                    .ruleService
                        )
                )
            }
        }
    }

    @ViewBuilder
    private var executeTab: some View {

        if #available(iOS 16.0, *) {

            NavigationStack {

                RuleExecutionView(
                    viewModel:
                        RuleExecutionViewModel(
                            ruleService:
                                container
                                    .ruleService,
                            ruleExecution:
                                container
                                    .ruleExecution,
                            executionHistoryRepository:
                                container
                                    .executionHistoryRepository
                        )
                )
            }

        } else {

            NavigationView {

                RuleExecutionView(
                    viewModel:
                        RuleExecutionViewModel(
                            ruleService:
                                container
                                    .ruleService,
                            ruleExecution:
                                container
                                    .ruleExecution,
                            executionHistoryRepository:
                                container
                                    .executionHistoryRepository
                        )
                )
            }
        }
    }

    @ViewBuilder
    private var historyTab: some View {

        if #available(iOS 16.0, *) {

            NavigationStack {

                RuleExecutionHistoryView(
                    viewModel:
                        RuleExecutionHistoryViewModel(
                            repository:
                                container
                                    .executionHistoryRepository
                        )
                )
            }

        } else {

            NavigationView {

                RuleExecutionHistoryView(
                    viewModel:
                        RuleExecutionHistoryViewModel(
                            repository:
                                container
                                    .executionHistoryRepository
                        )
                )
            }
        }
    }
    
    @ViewBuilder
    private var settingsTab: some View {

        if #available(iOS 16.0, *) {

            NavigationStack {

                SettingsView(viewModel: FBAuthViewModel(authService:container.authService))
            }

        } else {

            NavigationView {

                SettingsView(viewModel: FBAuthViewModel(authService: container.authService))
            }
        }
    }
}
