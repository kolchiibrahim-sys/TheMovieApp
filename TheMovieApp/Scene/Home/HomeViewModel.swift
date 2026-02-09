//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import Foundation

final class HomeViewModel {

    private let service: MovieServiceProtocol
    private(set) var items: [HomeModel] = []

    private var isSearching = false

    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }

    func loadHomeData() {
        isSearching = false
        items.removeAll()

        fetch(endpoint: .trendingMovies, title: "Trending Today")
        fetch(endpoint: .nowPlayingMovies, title: "Now Playing")
        fetch(endpoint: .upcomingMovies, title: "Upcoming")
        fetch(endpoint: .popularMovies, title: "Popular")
        fetch(endpoint: .topRatedMovies, title: "Top Rated")
    }

    private func fetch(endpoint: Endpoint, title: String) {
        service.fetchMovies(endpoint: endpoint) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.items.append(
                        HomeModel(title: title, movies: movies)
                    )
                    self?.onSuccess?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            completion([])
            return
        }

        isSearching = true
        items.removeAll()

        service.fetchMovies(endpoint: .searchMovies(query: trimmed)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movies):
                        completion(movies)
                    case .failure:
                        completion([])
                    }
                }
            }
        }

    func cancelSearch() {
        guard isSearching else { return }
        loadHomeData()
    }
}
