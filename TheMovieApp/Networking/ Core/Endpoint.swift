//
//  Endpoint.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 09.02.26.
//
import Foundation
import Alamofire

enum Endpoint {
    case popularMovies
    case nowPlayingMovies
    case upcomingMovies
    case topRatedMovies
    case popularActors
    case trendingMovies
}

extension Endpoint {

    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .nowPlayingMovies:
            return "/movie/now_playing"
        case .upcomingMovies:
            return "/movie/upcoming"
        case .topRatedMovies:
            return "/movie/top_rated"
        case .popularActors:
            return "/person/popular"
        case .trendingMovies:
            return "/trending/movie/day"
        }
    }

    var parameters: Parameters {
        [
            "language": "en-US",
            "page": 1
        ]
    }
}
