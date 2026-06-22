//
//  Rule.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import FirebaseFirestore

struct Rule: Codable, Identifiable {

    @DocumentID
    var id: String?
    let name: String
    let isActive: Bool
    let condition: RuleCondition
    let action: RuleAction
    let createdAt: Date
}
