//
//  HomeView.swift
//  thmanyah
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                // Display a loading indicator when data is being fetched for the first time
                VStack {
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                    Spacer()
                }
                .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            } else if let errorMessage = viewModel.errorMessage {
                // Display an error message with a retry button
                VStack {
                    Spacer()
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()

                    Button(action: {
                        Task {
                            await viewModel.fetchSections()
                        }
                    }) {
                        Text("Retry")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            } else {
                // Main content when data is loaded successfully
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.sections) { section in
                            SectionView(section: section)
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreSectionsIfNeeded(currentSection: section)
                                    }
                                }
                        }

                        if viewModel.isLoadingMore {
                            ProgressView()
                                .padding()
                        }
                    }
                    .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
                }
                .navigationTitle("Hello, Hady! 👋")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 15) {
                            Image(systemName: "bell")
                                .foregroundColor(.red)
                                .overlay(
                                    Circle()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.red)
                                        .offset(x: 8, y: -8)
                                )
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onAppear {
                    if viewModel.sections.isEmpty {
                        Task {
                            await viewModel.fetchSections()
                        }
                    }
                }
            }
        }
    }
}
