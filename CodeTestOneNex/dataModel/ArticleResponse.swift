//
//  ArticleResponse.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation

// MARK: - ArticleResponse
struct ArticleResponse: Codable {
    let message: String
    let data: [String: ArticleVO]?
    
    var articles: [ArticleVO] {
        return data?.values.map { $0 } ?? []
    }
}

// MARK: - Datum
struct ArticleVO: Codable {
    let id, articleCategoryID: Double
    let title, content: String
    let createdBy: Int
    let updatedBy, deletedBy: JSONNull?
    let createdAt, updatedAt: String
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case articleCategoryID = "article_category_id"
        case title, content
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case deletedBy = "deleted_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
    
   
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
