//
//  MoviesResponse.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import Foundation

struct MoviesResponse: Decodable, Sendable {
    let page: Int
    let results: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
