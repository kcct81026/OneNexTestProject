//
//  CategoryRespone.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let message: String
    let data: [String: CategoryVO]?
    
    var categories: [CategoryVO] {
        return data?.values.map { $0 } ?? []
    }
}

// MARK: - Datum
struct CategoryVO: Codable {
    let id: Double
    let name: String
    let createdBy, updatedBy, deletedBy: JSONNull?
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case deletedBy = "deleted_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
