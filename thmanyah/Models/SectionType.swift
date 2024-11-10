//
//  SectionType.swift
//  thmanyah
//

import Foundation

enum SectionType: String, Codable {
    case square = "square"
    case twoLinesGrid = "2_lines_grid"
    case list = "list"
    case fallback

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = SectionType(rawValue: rawValue) ?? .fallback
    }
}
