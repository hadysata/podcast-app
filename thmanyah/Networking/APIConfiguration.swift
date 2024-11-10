//
//  APIConfiguration.swift
//  thmanyah
//

import Foundation

struct APIConfiguration {
    static let baseURL = "https://api-v2-b2sit6oh3a-uc.a.run.app"

    enum Endpoint: String {
        case homeSections = "/home_sections"

        var url: URL? {
            return URL(string: APIConfiguration.baseURL + self.rawValue)
        }
    }
}
