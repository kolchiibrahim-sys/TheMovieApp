//
//  MovieService.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 09.02.26.
//
import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(
        endpoint: Endpoint,
        completion: @escaping (Result<[Movie], Error>) -> Void
    )
}
final class MovieService: MovieServiceProtocol {

    func fetchMovies(
        endpoint: Endpoint,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {

        APIClient.shared.request(
            endpoint: endpoint,
            responseType: MoviesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
