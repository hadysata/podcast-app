//
//  ContentItem.swift
//  thmanyah
//

import Foundation

struct ContentItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let avatarURL: String
    let episodeCount: Int?
    let duration: Int
    let priority: Int?
    let score: Double
    let releaseDate: Date?

    enum CodingKeys: String, CodingKey {
        case podcastId = "podcast_id"
        case episodeId = "episode_id"
        case name, description
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, priority, score
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let podcastId = try? container.decode(String.self, forKey: .podcastId) {
            self.id = "\(podcastId)-\(UUID().uuidString)"
        } else if let episodeId = try? container.decode(String.self, forKey: .episodeId) {
            self.id = "\(episodeId)-\(UUID().uuidString)"
        } else {
            self.id = UUID().uuidString // Fallback to a generated UUID
        }

        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.episodeCount = try? container.decode(Int.self, forKey: .episodeCount)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.priority = try? container.decode(Int.self, forKey: .priority)
        self.score = try container.decode(Double.self, forKey: .score)

        if let releaseDateString = try? container.decode(String.self, forKey: .releaseDate) {
            let dateFormatter = ISO8601DateFormatter()
            self.releaseDate = dateFormatter.date(from: releaseDateString)
        } else {
            self.releaseDate = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(id.components(separatedBy: "-").first, forKey: .podcastId)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(avatarURL, forKey: .avatarURL)
        try container.encodeIfPresent(episodeCount, forKey: .episodeCount)
        try container.encode(duration, forKey: .duration)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encode(score, forKey: .score)

        if let releaseDate = releaseDate {
            let dateFormatter = ISO8601DateFormatter()
            let dateString = dateFormatter.string(from: releaseDate)
            try container.encode(dateString, forKey: .releaseDate)
        }
    }
}
