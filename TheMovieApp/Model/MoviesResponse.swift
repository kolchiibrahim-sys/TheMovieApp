//
//  MoviesResponse.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//

import Foundation

struct MoviesResponse: Decodable , Sendable {
    let results: [Movie]
}
