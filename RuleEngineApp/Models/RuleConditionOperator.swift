//
//  RuleConditionOperator.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

enum RuleConditionOperator: String, Codable, CaseIterable, Identifiable {
    case equal
    case notEqual

    case greaterThan
    case lessThan

    case greaterThanOrEqual
    case lessThanOrEqual

    case contains

    var id: String {
        rawValue
    }

    var title: String {

        switch self {

        case .equal:
            return "=="

        case .notEqual:
            return "!="

        case .greaterThan:
            return ">"

        case .lessThan:
            return "<"

        case .greaterThanOrEqual:
            return ">="

        case .lessThanOrEqual:
            return "<="

        case .contains:
            return "contains"
        }
    }
}
