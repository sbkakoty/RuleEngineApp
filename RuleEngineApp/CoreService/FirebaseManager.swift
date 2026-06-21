//
//  FirebaseManager.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseCore

final class FirebaseManager {

    static let shared = FirebaseManager()

    private init() { }

    func configure() {
        FirebaseApp.configure()
    }
}
