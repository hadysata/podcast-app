//
//  APIServiceProtocol.swift
//  thmanyah

import Foundation

protocol APIServiceProtocol {
    func fetchSections(from url: URL?) async throws -> FetchResult
}
