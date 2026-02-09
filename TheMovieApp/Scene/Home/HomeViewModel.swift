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

    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }

    func loadHomeData() {
        items.removeAll()

        fetch(endpoint: .nowPlayingMovies, title: "Now Playing")
        fetch(endpoint: .popularMovies, title: "Popular")
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
}
