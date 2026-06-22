//
//  RuleExecutionHistoryService.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RuleExecutionHistoryService: RuleExecutionHistoryServiceProtocol {

    private let db = Firestore.firestore()

    private var uid: String {

        Auth.auth().currentUser?.uid ?? ""
    }

    func saveExecution(_ execution: Execution) async throws {

        try db.collection("users")
            .document(uid)
            .collection("executions")
            .addDocument(from: execution)
    }

    func fetchExecutions() async throws -> [Execution] {

        let snapshot = try await db
            .collection("users")
            .document(uid)
            .collection("executions")
            .order(by: "executedAt", descending: true)
            .getDocuments()

        return try snapshot.documents.map {

            try $0.data(
                as: Execution.self
            )
        }
    }
}
