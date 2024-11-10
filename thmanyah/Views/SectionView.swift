//
//  SectionView.swift
//  thmanyah
//

import SwiftUI

struct SectionView: View {
    let section: SectionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(section.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.orange)
            }
            .padding(.horizontal)

            // Render different layouts based on section type
            switch section.type {
            case .square:
                horizontalScrollView()
            case .twoLinesGrid:
                gridLayout()
            case .list:
                verticalListLayout()
            default:
                horizontalScrollView() // Fallback to a horizontal scroll
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: - Layout Methods

    @ViewBuilder
    private func horizontalScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(section.content) { item in
                    ContentCardView(item: item)
                        .frame(width: 180)
                }
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func gridLayout() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
            ForEach(section.content) { item in
                ContentCardView(item: item)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func verticalListLayout() -> some View {
        VStack(spacing: 15) {
            ForEach(section.content) { item in
                ContentCardView(item: item)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}
