//
//  Tags.swift
//  Finuncle
//
//  Created by Rahul on 02/04/23.
//

import Foundation

// MARK: - TagElement
struct TagElement: Codable, Identifiable, Hashable {
    var id: Int?
    let name: String
    var size: CGFloat? = 0
    var isSelected:Bool? = false
}

typealias Tags = [TagElement]

