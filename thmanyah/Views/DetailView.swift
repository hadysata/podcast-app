//
//  DetailView.swift
//  thmanyah
//

import SwiftUI

struct DetailView: View {
    let item: ContentItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                if let url = URL(string: item.avatarURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        Color.gray
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }


                Text(item.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text(HtmlFormatterUtils.parseHtmlTagsToMarkdown(item.description) )
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(.secondary)
              
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text(DateFormatterUtils.formatDuration(item.duration))
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    if let episodesCount = item.episodeCount {
                        Spacer()
                        Image(systemName: "list.bullet")
                            .foregroundColor(.orange)
                        Text("\(episodesCount) episodes")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)


                if let formattedDate = DateFormatterUtils.formatRelativeDate(item.releaseDate) {
                    Text("Released: \(formattedDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .navigationTitle("Episode Details")
        .navigationBarTitleDisplayMode(.inline)
    }

}
