//
//  DateFormatterUtils.swift
//  thmanyah
//

import Foundation

struct DateFormatterUtils {
    // Function to format a date as a relative string (e.g., "2 hours ago")
    static func formatRelativeDate(_ date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }

    // Function to format a duration (in seconds) as a string (e.g., "1h 30m")
    static func formatDuration(_ duration: Int) -> String {
        if duration < 60 {
            // Less than a minute, show in seconds
            return "\(duration) sec"
        } else if duration < 3600 {
            // Less than an hour, show in minutes
            let minutes = duration / 60
            return "\(minutes) min"
        } else {
            // 1 hour or more, show in hours and minutes
            let hours = duration / 3600
            let minutes = (duration % 3600) / 60
            return minutes > 0 ? "\(hours)h \(minutes)m" : "\(hours)h"
        }
    }
}
