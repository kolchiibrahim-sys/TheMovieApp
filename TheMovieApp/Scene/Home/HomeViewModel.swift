//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import Foundation

final class HomeViewModel {

    private(set) var items: [HomeModel] = []
    var onUpdate: (() -> Void)?

    private let service = MovieManager()

    func loadHomeData() {
        items = []
        fetch(.trendingMovies, title: "Trending Today")
        fetch(.nowPlayingMovies, title: "Now Playing")
        fetch(.upcomingMovies, title: "Upcoming")
        fetch(.popularMovies, title: "Popular")
        fetch(.topRatedMovies, title: "Top Rated")
    }

    private func fetch(_ endpoint: Endpoint, title: String) {
        service.fetchMovies(endpoint: endpoint) { [weak self] movies in
            guard let self else { return }

            let model = HomeModel(
                title: title,
                movies: movies,
                endpoint: endpoint
            )

            self.items.append(model)
            self.onUpdate?()
        }
    }
}
