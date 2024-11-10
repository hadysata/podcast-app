//
//  ContentCardView.swift
//  thmanyah
//

import SwiftUI

struct ContentCardView: View {
    let item: ContentItem

    var body: some View {
        NavigationLink(destination: DetailView(item: item)) {
            VStack(alignment: .leading, spacing: 8) {
                
                if let url = URL(string: item.avatarURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        Color.gray
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(.horizontal, 4)
                
                
                if let formattedDate = DateFormatterUtils.formatRelativeDate(item.releaseDate) {
                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 4)
                }
                
                
                HStack(spacing: 6) {
                    if let episodesCount = item.episodeCount {
                        HStack(spacing: 4) {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.orange)
                            Text("\(episodesCount)")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                            Spacer()
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text(DateFormatterUtils.formatDuration(item.duration))
                            .lineLimit(1)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 4)
            }
            .padding(6)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
        }
    }
}
