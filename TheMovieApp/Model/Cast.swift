//
//  Cast.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
//
import Foundation

struct CastResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let id: Int
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
