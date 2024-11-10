//
//  APIResponse.swift
//  thmanyah
//

import Foundation

struct APIResponse: Codable {
    let sections: [SectionModel]
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case sections, pagination
    }
}

struct Pagination: Codable {
    let nextPage: String
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
    }
}
