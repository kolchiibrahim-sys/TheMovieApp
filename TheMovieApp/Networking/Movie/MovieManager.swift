//
//  MovieManager.swift
//  TheMovieApp
//
//  Created by Kolchi Ibrahim on 04.02.26.
//
import Foundation
import Alamofire

@MainActor
final class MovieManager {

    func fetchMovies(endpoint: Endpoint,
                     completion: @escaping ([Movie]) -> Void) {
        request(MoviesResponse.self, endpoint: endpoint, page: nil) { response in
            completion(response?.results ?? [])
        }
    }

    func fetchMovies(endpoint: Endpoint,
                     page: Int,
                     completion: @escaping ([Movie], Int) -> Void) {
        request(MoviesResponse.self, endpoint: endpoint, page: page) { response in
            completion(response?.results ?? [], response?.totalPages ?? 1)
        }
    }

    func fetchMovieDetail(id: Int,
                          completion: @escaping (Movie?) -> Void) {
        request(Movie.self, endpoint: .movieDetail(id: id), page: nil) { movie in
            completion(movie)
        }
    }

    func fetchCast(movieId: Int,
                   completion: @escaping ([Cast]) -> Void) {
        request(CastResponse.self,
                endpoint: .movieCredits(id: movieId),
                page: nil) { response in
            completion(response?.cast ?? [])
        }
    }

    func fetchReviews(movieId: Int,
                      completion: @escaping ([Review]) -> Void) {
        request(ReviewResponse.self,
                endpoint: .movieReviews(id: movieId),
                page: nil) { response in
            completion(response?.results ?? [])
        }
    }

    private func request<T: Decodable>(_ type: T.Type,
                                       endpoint: Endpoint,
                                       page: Int?,
                                       completion: @escaping (T?) -> Void) {

        var params = endpoint.parameters ?? [:]
        if let page { params["page"] = page }

        let url = CoreHelper.shared.configureURL(endpoint: endpoint.path)

        AF.request(url,
                   parameters: params,
                   headers: CoreHelper.shared.headers)
        .responseDecodable(of: T.self) { response in
            completion(response.value)
        }
    }
}
