//
//  HomeViewModel.swift
//  thmanyah
//

import Combine
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sections: [SectionModel] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String? = nil

    private let apiService: APIServiceProtocol
    private var currentPage: Int = 1
    private var totalPages: Int = 1

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        Task {
            await fetchSections()
        }
    }

    func fetchSections() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            let fetchResult = try await apiService.fetchSections(from: URL(string: "\(APIConfiguration.baseURL)/home_sections"))
            sections = fetchResult.sections
            totalPages = fetchResult.pagination.totalPages
        } catch {
            errorMessage = "Failed to load sections: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func loadMoreSectionsIfNeeded(currentSection: SectionModel) async {
        guard !isLoadingMore, currentPage < totalPages else { return }

        if let lastSection = sections.last, currentSection.id == lastSection.id {
            isLoadingMore = true
            currentPage += 1

            do {
                let nextPageURL = URL(string: "\(APIConfiguration.baseURL)/home_sections?page=\(currentPage)")!
                let nextPageResult = try await apiService.fetchSections(from: nextPageURL)
                sections.append(contentsOf: nextPageResult.sections)
            } catch {
                print("Failed to load more sections: \(error)")
            }

            isLoadingMore = false
        }
    }
}
