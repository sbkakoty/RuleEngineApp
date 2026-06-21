//
//  FBSessionViewModel.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseAuth
import Foundation
import Combine

@MainActor
final class FBSessionViewModel: ObservableObject {

    @Published var isLoggedIn = false
    @Published var isLoadingSession: Bool = true

    private var listener: AuthStateDidChangeListenerHandle?
        
    init() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isLoggedIn = (user != nil)
                self?.isLoadingSession = false
            }
        }
    }

    deinit {

        if let listener {

            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
}
