//
//  APIService.swift
//  thmanyah
//

import Foundation

struct FetchResult {
    let sections: [SectionModel]
    let pagination: Pagination
}

class APIService: APIServiceProtocol {
    private let session: URLSession

    init(session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Custom timeout for requests
        configuration.timeoutIntervalForResource = 60 // Custom timeout for resources
        return URLSession(configuration: configuration)
    }()) {
        self.session = session
    }

    func fetchSections(from url: URL? = APIConfiguration.Endpoint.homeSections.url) async throws -> FetchResult {
        guard let url = url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)

        // Convert the next page to an absolute URL if necessary
        var nextPageURL: URL? = nil
        if let nextPage = URL(string: decodedResponse.pagination.nextPage), nextPage.scheme == nil {
            // Append the relative path to the base URL
            nextPageURL = URL(string: APIConfiguration.baseURL + nextPage.path)
        } else {
            nextPageURL = URL(string: decodedResponse.pagination.nextPage)
        }


        return FetchResult(sections: decodedResponse.sections, pagination: Pagination(nextPage: nextPageURL?.absoluteString ?? "", totalPages: decodedResponse.pagination.totalPages))
    }
}
