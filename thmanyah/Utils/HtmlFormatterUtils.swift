//
//  HtmlFormatterUtils.swift
//  thmanyah
//

import Foundation
import SwiftSoup

struct HtmlFormatterUtils {
    
    // Helper function to format text by replacing HTML tags with Markdown
    static func parseHtmlTagsToMarkdown(_ description: String) -> AttributedString {
        do {

            let doc: Document = try SwiftSoup.parse(description)


            try doc.select("br").prepend("\n")


            var attributedString = AttributedString(try doc.text())
            for link in try doc.select("a") {
                let href = try link.attr("href")
                let linkText = try link.text()
                
                if let range = attributedString.range(of: linkText) {
                    attributedString[range].link = URL(string: href)
                    attributedString[range].foregroundColor = .blue
                    attributedString[range].underlineStyle = .single
                }
            }

            return attributedString
        } catch {
            print("Error parsing HTML: \(error)")
            return AttributedString(description) // Fallback to the original description if parsing fails
        }
    }
}
