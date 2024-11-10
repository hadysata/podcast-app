//
//  SectionModel.swift
//  thmanyah
//

import Foundation

struct SectionModel: Identifiable, Codable {
    let id = UUID() // Unique identifier
    let name: String
    let type: SectionType
    let contentType: String
    let order: Int
    let content: [ContentItem]

    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}


