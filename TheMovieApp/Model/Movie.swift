//
//  Movie.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import Foundation

struct Movie: Decodable , Sendable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(
            string: "https://image.tmdb.org/t/p/w500\(posterPath)"
        )
    }
}
