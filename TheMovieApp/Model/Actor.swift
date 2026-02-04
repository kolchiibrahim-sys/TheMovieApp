//
//  Actor.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 04.02.26.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let actor = try? JSONDecoder().decode(Actor.self, from: jsonData)

// MARK: - Actor
struct Actor: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let gender, id: Int
    let knownFor: [KnownFor]
    let knownForDepartment: KnownForDepartment?
    let name: String
    let popularity: Double
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownForDepartment
enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
    case production = "Production"
    case writing = "Writing"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        switch rawValue {
        case "Acting": self = .acting
        case "Directing": self = .directing
        case "Production": self = .production
        case "Writing": self = .writing
        default: self = .unknown
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if self == .unknown {
            try container.encode("unknown")
        } else {
            try container.encode(self.rawValue)
        }
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let mediaType: MediaType?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let firstAirDate: String?
    let name: String?
    let originCountry: [String]?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}
// MARK: - MediaType
enum MediaType: String, Codable {
    case movie
    case tv
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        switch rawValue {
        case "movie": self = .movie
        case "tv": self = .tv
        default: self = .unknown
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if self == .unknown {
            try container.encode("unknown")
        } else {
            try container.encode(self.rawValue)
        }
    }
}

// MARK: - OriginalLanguage
enum OriginalLanguage: Codable, Equatable {
    case en
    case ja
    case ko
    case es
    case fr
    case unknown(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        switch rawValue {
        case "en": self = .en
        case "ja": self = .ja
        case "ko": self = .ko
        case "es": self = .es
        case "fr": self = .fr
        default: self = .unknown(rawValue)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .en: try container.encode("en")
        case .ja: try container.encode("ja")
        case .ko: try container.encode("ko")
        case .es: try container.encode("es")
        case .fr: try container.encode("fr")
        case .unknown(let value): try container.encode(value)
        }
    }
}

