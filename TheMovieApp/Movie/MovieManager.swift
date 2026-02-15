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

    func fetchMovies(
        endpoint: Endpoint,
        page: Int,
        completion: @escaping ([Movie], Int) -> Void
    ) {
        var params = endpoint.parameters ?? [:]
        params["page"] = page

        let url = CoreHelper.shared.configureURL(endpoint: endpoint.path)

        AF.request(
            url,
            parameters: params,
            headers: CoreHelper.shared.headers
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder()
                        .decode(MoviesResponse.self, from: data)
                    completion(decoded.results, decoded.totalPages)
                } catch {
                    completion([], 1)
                }
            case .failure:
                completion([], 1)
            }
        }
    }

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
