//
//  RuleCondition.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

struct RuleCondition: Codable {

    let field: String

    let operation: RuleConditionOperator

    let value: String
}
