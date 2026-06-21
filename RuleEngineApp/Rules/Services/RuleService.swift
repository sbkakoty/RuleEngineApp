//
//  RuleService.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseAuth
import FirebaseFirestore

final class RuleService: RuleServiceProtocol {

    private let db = Firestore.firestore()

    private var uid: String {

        Auth.auth()
            .currentUser?
            .uid ?? ""
    }

    func fetchRules() async throws -> [Rule] {

        let snapshot = try await db
            .collection("users")
            .document(uid)
            .collection("rules")
            .order(
                by: "createdAt",
                descending: true
            )
            .getDocuments()

        return try snapshot.documents.map {

            try $0.data(as: Rule.self)
        }
    }

    func createRule(_ rule: Rule) async throws {

        try db.collection("users")
            .document(uid)
            .collection("rules")
            .addDocument(from: rule)
    }

    func updateRule(_ rule: Rule) async throws {

        guard let id = rule.id else { return }

        try db.collection("users")
            .document(uid)
            .collection("rules")
            .document(id)
            .setData(from: rule)
    }

    func deleteRule(id: String) async throws {

        try await db.collection("users")
            .document(uid)
            .collection("rules")
            .document(id)
            .delete()
    }
}
