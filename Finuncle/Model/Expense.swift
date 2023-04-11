//
//  Expense.swift
//  Finuncle
//
//  Created by Rahul on 02/04/23.
//

import Foundation

// MARK: - ExpenseElement
struct ExpenseElement: Codable {
    let id: Int
    let time: String
    let amount: String
    let user: Int
    let tags: [Int]
}

typealias Expenses = [ExpenseElement]

extension ExpenseElement {
    
    var dateString: String {
        if let date = time.convertDateString() {
            return date
        } else {
            return self.time
        }
    }
    
    var tagsData: String {
        return tags.compactMap { tagId in
            K.tags.first(where: { $0.id == tagId })
        }.compactMap { $0.name }.joined(separator: ", ")
    }
    
}
