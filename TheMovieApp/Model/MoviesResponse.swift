//
//  MoviesResponse.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//


import Foundation

struct MoviesResponse: Codable {
    let results: [Movies]
}

struct Movies: Codable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
}
