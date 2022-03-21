//
//  DayData.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 15/03/22.
//

import Foundation

struct DayResponse: Decodable {
    let selected: [Selected]
}

struct Selected: Decodable {
    let text: String
    let year: Int
    let pages: [Pages]
}

struct Pages: Decodable {
    let pageId: Int
    let titles: Titles
    let thumbnail: Thumbnail?
    let originalImage: OriginalImage?
    let contentUrls: ContentUrls
    let extract: String
    
    enum CodingKeys: String, CodingKey {
        case titles
        case pageId = "pageid"
        case thumbnail
        case originalImage = "originalimage"
        case contentUrls = "content_urls"
        case extract
    }
}

struct Titles: Decodable {
    let normalized: String
}

struct Thumbnail: Decodable {
    let source: String
}

struct OriginalImage: Decodable {
    let source: String
}

struct ContentUrls: Decodable {
    let desktop: Desktop
}

struct Desktop: Decodable {
    let page: String
}
