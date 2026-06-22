//
//  RuleExecutionService.swift
//  RuleEngineApp
//
//  Created by Sonjoy Borkakoty on 17/06/26.
//

import Foundation

final class RuleExecutionService: RuleExecutionServiceProtocol {

    func execute(event: [String : Any], rules: [Rule]) -> ExecutionResult {

        let activeRules = rules.filter {
            $0.isActive
        }

        var matchedRules: [Rule] = []

        for rule in activeRules {

            if evaluate(rule: rule, event: event) {
                matchedRules.append(rule)
            }
        }

        return ExecutionResult(
            triggeredRules: matchedRules.map(\.name),
            actions: matchedRules.map {
                $0.action.message
            }
        )
    }
}

extension RuleExecutionService {

    func evaluate(rule: Rule, event: [String: Any]) -> Bool {

        let condition = rule.condition

        guard let eventValue = event[condition.field] else { return false }

        return compare(eventValue: eventValue, condition: condition)
    }
    
    func compare(eventValue: Any, condition: RuleCondition) -> Bool {

        switch condition.operation {

        case .equal:
            return "\(eventValue)" == condition.value

        case .notEqual:
            return "\(eventValue)" != condition.value

        case .contains:
            return "\(eventValue)".localizedCaseInsensitiveContains(condition.value)

        case .greaterThan, .lessThan, .greaterThanOrEqual, .lessThanOrEqual:

            guard let result = compareNumbers(lhs: eventValue, rhs: condition.value) else {
                return false
            }

            switch condition.operation {

            case .greaterThan:
                return result > 0

            case .lessThan:
                return result < 0

            case .greaterThanOrEqual:
                return result >= 0

            case .lessThanOrEqual:
                return result <= 0

            default:
                return false
            }
        }
    }
    
    func compareNumbers(lhs: Any, rhs: String) -> Double? {

        guard let left = Double("\(lhs)"), let right = Double(rhs) else { return nil }

        return left - right
    }
}
