//
//  MovieManager.swift
//  TheMovieApp
//
//  Created by Shamkhal Guliyev on 04.02.26.
//
import Foundation
import Alamofire

@MainActor
final class MovieManager {

    // MARK: - List / Home / Search
    func fetchMovies(
        endpoint: Endpoint,
        completion: @escaping ([Movie]) -> Void
    ) {

        let url = CoreHelper.shared.configureURL(endpoint: endpoint.path)

        AF.request(
            url,
            parameters: endpoint.parameters,
            headers: CoreHelper.shared.headers
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder()
                        .decode(MoviesResponse.self, from: data)
                    completion(decoded.results)
                } catch {
                    completion([])
                }

            case .failure:
                completion([])
            }
        }
    }

    // MARK: - Movie Detail (Favorites üçün)
    func fetchMovieDetail(
        id: Int,
        completion: @escaping (Movie?) -> Void
    ) {

        let endpoint = Endpoint.movieDetail(id: id)
        let url = CoreHelper.shared.configureURL(endpoint: endpoint.path)

        AF.request(
            url,
            parameters: endpoint.parameters,
            headers: CoreHelper.shared.headers
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder()
                        .decode(Movie.self, from: data)
                    completion(movie)
                } catch {
                    completion(nil)
                }

            case .failure:
                completion(nil)
            }
        }
    }
}
