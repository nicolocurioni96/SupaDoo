//
//  Shoppings.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 15/11/23.
//

import Foundation

struct Shoppings: Codable, Identifiable, Hashable {
    var id: Int?
    var createdAt: Date
    var name: String
    var isComplete: Bool
    var userID: UUID
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case isComplete = "is_complete"
        case userID = "user_id"
    }
}
