//
//  RuleEngineAppApp.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 16/06/26.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct RuleEngineAppApp: App {
    
    init() {
        FirebaseApp.configure()
        
        let settings = FirestoreSettings()
        settings.cacheSettings = PersistentCacheSettings(
            sizeBytes: 500 * 1024 * 1024 as NSNumber
        )

        Firestore.firestore().settings = settings
        
        print("Firebase successfully initialized inside App initialization scope.")
        
        if ProcessInfo.processInfo.arguments.contains("--uitesting") &&  ProcessInfo.processInfo.arguments.contains("--logout") {

            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
