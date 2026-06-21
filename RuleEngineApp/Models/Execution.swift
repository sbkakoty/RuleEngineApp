//
//  Execution.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseFirestore

struct Execution: Codable, Identifiable {

    @DocumentID
    var id: String?

    let eventPayload: [String:String]

    let triggeredRules: [String]

    let actions: [String]

    let executedAt: Date

    let success: Bool
}
