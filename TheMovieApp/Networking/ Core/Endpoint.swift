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
    case searchMovies(query: String)
    case movieDetail(id: Int)
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
        case .searchMovies:
            return "/search/movie"
        case .movieDetail(let id):
            return "/movie/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchMovies(let query):
            return [
                "query": query,
                "language": "en-US",
                "include_adult": false
            ]
        default:
            return [
                "language": "en-US"
            ]
        }
    }
}
